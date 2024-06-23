//
//  BottomDetailPopup.swift
//  prodapp
//
//  Created by Dhruva Ramachandran on 3/28/24.
//

import Foundation
import MijickPopupView
import SwiftUI

struct BottomDetailPopup: BottomPopup {
    @Binding var job: Job
    @Binding var jobs: [Job]
    func configurePopup(popup: BottomPopupConfig) -> BottomPopupConfig {
        popup
            .backgroundColour(Color.onBackgroundPrimary)
    }
    func createContent() -> some View {
        HStack(spacing: 0){
            VStack(alignment: .leading, spacing: 5){
                    createTitle()
                    Spacer().frame(height: 2)
                    createTimeText()
                    Spacer().frame(height: 5)
            }
            .background(Color.onBackgroundSecondary)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding().frame(width: 300)
            VStack(alignment: .leading, spacing: 10){
                createEdit()
                Spacer().frame(height: 3)
                createTimer()
                Spacer().frame(height: 5)
                createDelete()
            }
        }
       
    }
    

}
private extension BottomDetailPopup {
    func createTitle() -> some View {
        Text(job.name)
            .frame(width: 250, alignment: .leading)
            .foregroundColor(.white)
            .padding()
            .font(Font.satoshiMedium(25))
            
    }
    func createTimeText() -> some View{
        Text(String(format: "%02d / %02d", job.mins, job.breakMins) + " Work to Break Split")
            .frame(width: 250, alignment: .leading)
            .foregroundColor(.white)
            .padding()
            .font(Font.satoshiMedium(20))
        
        
    }
    func createDelete() -> some View{
        Button{
            jobs.remove(at: jobs.firstIndex(of: job)!)
            dismiss()
        } label :{
            Text("Delete")
                .frame(width: 55, height: 22)
                .foregroundStyle(.white)
                .background(.red)
                .mask(Capsule())
                .font(Font.satoshiMedium(17))
        }
    }
    func createEdit() -> some View {
        Button {
            BottomEditPopup(jobs: $jobs, job: $job).showAndStack()
        } label: {
            Text("Edit")
                .frame(width: 55, height: 18)
                .foregroundStyle(.white)
                .overlay(Capsule().stroke(Color.onBackgroundSecondary, lineWidth: 2))
                .font(Font.satoshiMedium(17))
        }
    }
    func createTimer() -> some View {
        Button {
            TimerPopupFullScreen(job: $job, jobs: $jobs).showAndStack()
        } label: {
            Text("Timer")
                .frame(width: 55, height: 18)
                .foregroundStyle(.white)
                .overlay(Capsule().stroke(Color.onBackgroundSecondary, lineWidth: 2))
                .font(Font.satoshiMedium(17))
        }
    }
}
private extension BottomDetailPopup{
    func onButtonTap() -> some View{
        TimerView(job: $job, jobs: $jobs, saveTime: {})
    }
}
