//
//  TimerView.swift
//  prodapp
//
//  Created by Dhruva Ramachandran on 2/26/24.
//

import SwiftUI
import CoreMotion
import UserNotifications
import AVFoundation

struct TimerView: View {
    @Binding var job: Job
    @Binding var jobs: [Job]
    var resumeTimer = ResumeTimer()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let jTimer = JobTimer2()
    @State var count = 0
    let saveTime: () -> Void
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.dismiss) var dismiss
    let manager = CMMotionManager()
    @State var workTimeActive = true
    @State var needToStart = true
    @State var firstWork = true
    @State var firstBreak = true
    @State var totalRotation = 0.0
    @State var faceUp = true
    @State var stopText = ""
    @State var flipped = false
    @State var currentTime = ""
    @State var secsToAdd = 0.0
    var titleLabel = UILabel()
    @State var pomoCount = 0
    @State var pomoText = ""
    @State var oldBreakTime = 0
    @State var player: AVAudioPlayer?
    
    let userDefaults = UserDefaults.standard
    
    var body: some View {
        
        VStack{
            Text(job.name).font(Font.satoshiMedium(33))
            Spacer().frame(height: 40.0)
            Text("Place phone face down to start timer").font(.subheadline)
            Spacer().frame(height: 5)
        }
        
        Circle()
            .strokeBorder(lineWidth: 23)
            .foregroundStyle(Color.onBackgroundSecondary)
            .overlay{
                Text(currentTime).font(Font.panchangSemiBold(35))
                    .onReceive(timer){ _ in
                        count += 1
                        if count > 2 {
                            totalRotation = 0
                            count = 0
                        }
                        if workTimeActive && needToStart{
                            needToStart = false
                            jTimer.startTime(newJob: job)
                            manager.startGyroUpdates()
                        }
                        /*if jTimer.mins == "000" {
                            needToStart = true
                            workTimeActive = false
                        }*/
                        
                        if workTimeActive{
                            if firstWork {
                                jTimer.start = Date.now
                                firstWork = false
                            }
                            if (jTimer.mins == "000") {
                                print("reached 0 statement")
                                playAlert()
                                workTimeActive = false
                                firstBreak = true
                                pomoCount += 1
                                if pomoCount == 4 {
                                    oldBreakTime = job.breakMins
                                    job.breakMins = job.breakMins*2
                                    pomoText = "Take an extra long break, good work!"
                                }
                            }
                            
                            let dTheta = Double(self.manager.gyroData?.rotationRate.y ?? 0)
                            print("dtheta: \(dTheta)")
                            if dTheta > 0.1 || dTheta < -0.1 {
                                totalRotation = totalRotation + dTheta
                            }
                            
                            //print("totalRotation: \(totalRotation)")
                            if(abs(totalRotation) >= 0.9) {
                                print("Phone flip")
                                if faceUp == true {
                                    stopText = ""
                                    flipped = true
                                    faceUp = false
                                    playStart()
                                }
                                else if faceUp == false {
                                    //print("faceUp changed to true")
                                    faceUp = true
                                    stopText = "Timer paused at \(jTimer.time)"
                                    playStop()
                                }
                                totalRotation = 0
                                if manager.isGyroActive == false {print("not active tag 2")}
                            }
                            if !faceUp {
                                jTimer.dispWorkTime(job: job, secsToAdd: secsToAdd)
                            }
                            else if faceUp {
                                print("waiting")
                                secsToAdd += 1.0
                                
                            }
                            currentTime = jTimer.time
                            print(jTimer.time)
                            print(totalRotation)
                            //userDefaults.setValue(currentTime, forKey: "timeToDisp")
                        }
                        
                        else if !workTimeActive {
                            if firstBreak{
                                jTimer.start = Date.now
                                firstBreak = false
                            }
                            if jTimer.breakMins == "000"{
                                playAlert()
                                workTimeActive = true
                                firstWork = true
                                faceUp = true
                                if pomoCount == 4{
                                    job.breakMins = oldBreakTime
                                    pomoCount = 0
                                }
                            }
                            
                            print("break time")
                            jTimer.dispBreakTime(job: job)
                            currentTime = jTimer.time
                        }
                }
            }
        
        Text(stopText)
        Spacer().frame(height: 70.0)
        VStack{
            Button{
                dismissAll()
                jobs.remove(at: jobs.firstIndex(of: job)!)
            } label :{
                Text("Finish")
                    .font(Font.satoshiMedium(18))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 46)
                    .background(Color.onBackgroundSecondary)
                    .cornerRadius(8)
                
            }
        }.padding(.bottom, 14)
            .padding(.leading, 10)
            .padding(.trailing, 10)
    }
    
        
}
extension TimerView{
    func playAlert() {
        print("went here")
        let path = Bundle.main.path(forResource: "level-up-191997.wav", ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            print("played?")
        } catch {
            // couldn't load file :(
        }
    }
    func playStart() {
        let path = Bundle.main.path(forResource: "StartDing.wav", ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            print("played?")
        } catch {
            // couldn't load file :(
        }
    }
    func playStop() {
        let path = Bundle.main.path(forResource: "Stop.wav", ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            print("played?")
        } catch {
            // couldn't load file :(
        }
    }

}

