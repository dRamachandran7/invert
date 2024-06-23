//
//  EditJob.swift
//  prodapp
//
//  Created by Dhruva Ramachandran on 4/1/24.
//

import SwiftUI

struct EditJob: View {
    @State private var currentTaskName: String = ""
    @State private var currentTaskHours: Int = 0
    @State private var currentTaskMins: Int = 1
    @Binding var jobs: [Job]
    @State private var isEditing = false
    @State private var difficultyIndex = 0.0
    @State private var breakMins: Int = 1
    @State private var breakHours: Int = 0
    @Binding var job: Job
    @State private var suggestH: Int = 0
    @State private var suggestM: Int = 0
    @State private var suggestB: Int = 0
   
    
    var body: some View {
        ScrollView{
            VStack(spacing: 5) {
                TextField(
                    "Enter a new Name",
                    text: $currentTaskName
                ).padding()
                Slider(value: $difficultyIndex, in: 0...3,   onEditingChanged:{ editing in
                    isEditing = editing
                }
                ).padding()
                
                    .onChange(of: difficultyIndex){ index in
                        updateJobTime(difficultyIndex: Int(index))
                    }
               
                VStack(alignment: .leading, spacing: 4){
                    Text("Difficulty Rating: \((difficultyIndex), specifier: "%.1f")").font(Font.satoshiMedium(20))
                }
                .frame(maxWidth: .infinity)
                .frame(height: 75)
                .background(Color.onBackgroundSecondary)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                .foregroundStyle(Color.textOnPastel)
                .padding()
                Spacer().frame(height: 20)
                VStack(alignment: .leading){
                    Text("Suggestions: ").font(Font.nexaHeavy(25)).frame(alignment: .leading)
                    Text("\(suggestM) mins working, \(suggestB) mins break").font(Font.satoshiMedium(18)).frame(alignment: .leading)
                }
                Spacer().frame(height: 60)
                
                HStack {
                    VStack {
                        Text("Work: \(currentTaskMins)")
                            .font(Font.satoshiMedium(15))
                            .foregroundStyle(.white)
                        Stepper(value: $currentTaskMins, in: 0...100) {
                            Text("")
                        }.padding()
                    }
            
                    Spacer().frame(width: 100)
                    VStack{
                        Text("Break: \(breakMins)")
                            .font(Font.satoshiMedium(15))
                            .foregroundStyle(.white)
                        Stepper(value: $breakMins, in: 0...100) {
                            Text("")
                        }.padding()
                    }
                    Spacer().frame(height: 4)
                }
               
                Spacer().frame(height: 4)
                                HStack {
                    Button() {
                        dismissAll()
                    } label: {
                        Text("Cancel")
                            .frame(width: 75, height: 30)
                            .font(Font.satoshiMedium(20))
                            .background(Color.buttonBlue)
                            .foregroundStyle(.white)
                            .mask(Capsule())
                    }
                    Spacer().frame(width: 100)
                    Button() {
                        if (currentTaskName != "" && currentTaskMins != 0 && breakMins != 0){
                            let currentTask: Job = Job(name: currentTaskName, hours: currentTaskHours, mins: currentTaskMins, secs: 0, breakMins: breakMins, breakHours: breakHours, breakSecs: 0)
                            job = currentTask
                            dismissAll()
                            PopupNotif().showAndStack()
                        }
                        else{
                            CenterNoDataAlert().showAndStack()
                        }
                    } label: {
                        
                        Text("Save")
                            .frame(width: 75, height: 30)
                            .font(Font.satoshiMedium(20))
                            .background(Color.buttonBlue)
                            .foregroundStyle(.white)
                            .mask(Capsule())
                    }
                }
            }
        }
        
    }
    private func updateJobTime (difficultyIndex: Int) {
        if difficultyIndex >= 0 && difficultyIndex < 1 {
            currentTaskMins = 25
            currentTaskHours = 0
            breakMins = 5
            suggestM = 25
            suggestB = 5
        }
        else if difficultyIndex >= 1 && difficultyIndex < 2 {
            currentTaskMins = 35
            currentTaskHours = 0
            breakMins = 10
            suggestM = 35
            suggestB = 10
        }
        else {
            currentTaskHours = 0
            currentTaskMins = 60
            breakMins = 15
            suggestM = 60
            suggestB = 15
        }
    }
}
extension EditJob {
    func createBar() -> some View {
        Capsule()
            .fill(.white)
            .frame(width: 35, height: 3, alignment: .center)
            
    }
}
