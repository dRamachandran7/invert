//
//  JobCardView.swift
//  prodapp
//
//  Created by Dhruva Ramachandran on 1/15/24.
//

import SwiftUI
import CoreMotion

struct JobCardView: View {
    @Binding var jobs: [Job]
    @Binding var job: Job
    @Binding var timeClosed: Date
    @Binding var mustRedo: Bool
    var manager = CMMotionManager()
    let userDefaults = UserDefaults.standard
    
    let timer = JobTimer2()
    
    var body: some View {
        
        VStack(alignment: .leading){
            let timetoDisp = String(format: "%02d:%02d", job.mins, job.seconds, " work time")
            Text(job.name)
                .font(Font.satoshiMedium(20))
                .multilineTextAlignment(.leading).padding()
            HStack(spacing: 3){
                Spacer().frame(width: 280)
                Button{
                    /*for family: String in UIFont.familyNames {
                        print(family)
                        for names: String in UIFont.fontNames(forFamilyName: family) {
                            print("== \(names)")
                        }
                    }*/
                    BottomDetailPopup(job: $job, jobs: $jobs).showAndStack()
                } label: {
                    Image(systemName: "arrowshape.right")
                }
            }
            HStack{
                Text(timetoDisp)
                    .font(Font.satoshiMedium(10))
                    .multilineTextAlignment(.leading)
                //Spacer().frame(width: 200)
               
                
            }.padding()
           
           
        }
        
        }
        
    }

struct CardView_Previews: PreviewProvider {
    static var job = Job.sampleData[0]
    static var previews: some View {
        JobCardView(jobs: .constant(Job.sampleData), job: .constant(job), timeClosed: .constant(Date.now), mustRedo: .constant(false))
            
    }
}
