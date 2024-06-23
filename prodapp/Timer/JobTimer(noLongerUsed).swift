import UIKit
import SwiftUI
import Combine
import CoreMotion


struct JobTimer: View {
    
    @Binding var timeClosed: Date
    @Binding var job: Job
    @Binding var jobs: [Job]
    @Binding var mustRedo: Bool
    @Binding var manager: CMMotionManager
    
    @State var seconds = 0
    @State var start = Date.now
    @State var tO = Date.now
    @State var currentTimeRemaining = "00:00:00"
    @State var currentGyroRotation = 0.0
    @State var secsDone = false
    @State var minsDone = false
    @State var faceUp = true
    @State var canContinue = true
    @State var stopText = ""
    @State var workTimeActive = true
    @State var breakText = ""
    @State var totalRotation = 0.0
    @State var count = 0
    //@State var audioPlayer = AVAudioPlayer()
    
    var resumeTimer = ResumeTimer()
    @State var userDefaults = UserDefaults.standard
   
    
    
    @State private var cancellable: AnyCancellable?
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.dismiss) var dismiss
    let saveTime: () -> Void
   
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let checkTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let currentTime = Date.now
    
    var body: some View {
        Text(job.name).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).padding()
        
        Button{
            totalRotation = 1.0
        } label: {
            Text("Simulate flipping the phone over")
        }
        Text(breakText)
        Text(currentTimeRemaining).font(.title)
            .onReceive(timer) { _ in
                if manager.isGyroActive { print("active")}
                if manager.isGyroActive == false {
                    print("not active tag 0")
                    
                }
                count += 1
                if count > 2{
                    totalRotation = 0
                    count = 0
                }
                if workTimeActive == false {
                    breakText = "Break time!"
                    currentTimeRemaining = String(format: "%02d:%02d", job.breakMins, job.breakSecs)
                    keepScreenOn()
                    minsDone = false
                    secsDone = false
                    
                    let hours = job.breakHours
                    let mins = job.breakMins
                    let secs = job.breakSecs
            
                    if mins == 0 {
                        minsDone = true
                    }
                    if secs == 0 && mins == 0 {
                        secsDone = true
                    }
                    if mins == 0 && minsDone == false {
                        job.setBreakHours(new: (hours-1))
                        job.setBreakMins(new: 59)
                    }
                    if job.breakSecs == 0 && secsDone == false{
                        job.setBreakMins(new: (mins-1))
                        job.setBreakSecs(new: 59)
                    }
                    if hours == 0 && minsDone == true && secsDone == true {
                        /*let url = Bundle.main.url(forResource: "ding", withExtension: "mp3")
                        
                        do{
                            audioPlayer = try AVAudioPlayer(contentsOf: url!)
                            audioPlayer.play()
                        }
                        catch{
                            print("error")
                        }*/
                        workTimeActive = true
                        
                    }
                    else {
                        job.setBreakSecs(new: job.breakSecs-1)
                    }
                    
                }
                else{
                    if manager.isGyroActive == false {print("not active tag 1")}
                    let dTheta = Double(self.manager.gyroData?.rotationRate.y ?? 0)
                    print("dtheta: \(dTheta)")
                    if dTheta > 0.1 || dTheta < -0.1 {
                        totalRotation = totalRotation + dTheta
                    }
                    
                    //print("totalRotation: \(totalRotation)")
                    if(totalRotation >= 0.9 || totalRotation <= -0.9) {
                        print("Phone flip")
                        if faceUp == true {
                            //print("faceUp changed to false")
                            faceUp = false
                        }
                        else if faceUp == false {
                            //print("faceUp changed to true")
                            faceUp = true
                            stopText = "Timer paused at \(currentTimeRemaining)"
                        }
                        totalRotation = 0
                        if manager.isGyroActive == false {print("not active tag 2")}
                    }
                    
                    /*guard shouldProceed() else {
                        
                        return
                    }*/
                    
                    if shouldProceed() == true{
                        currentTimeRemaining = dispTime(mustRedo: mustRedo)
                        keepScreenOn()
                        let hours = job.hours
                        let mins = job.mins
                        let secs = job.seconds
                        
                        if mins == 0 && hours == 0 {
                            minsDone = true
                        }
                        if secs == 0 && mins == 0 {
                            secsDone = true
                        }
                        if mins == 0 && minsDone == false {
                            job.setHours(new: (hours-1))
                            job.setMins(new: 59)
                        }
                        if job.seconds == 0 && secsDone == false{
                            job.setMins(new: (mins-1))
                            job.setSeconds(new: 59)
                        }
                        if hours == 0 && minsDone == true && secsDone == true {
                            workTimeActive = false
                            //stopTimer()
                        }
                        else {
                            job.setSeconds(new: job.seconds-1)
                        }
                        if manager.isGyroActive == false {print("not active tag 3")}
                        currentTimeRemaining = dispTime(mustRedo: mustRedo)
                    }
                    if manager.isGyroActive == false {print("not active tag 4")}
                }
            }
        Text("Flip phone over to start timer").font(.subheadline).bold()
        Text(stopText)
        Button{
            jobs.remove(at: jobs.firstIndex(of: job)!)
            dismiss()
        } label :{
            Text("Finish")
        }
            .onChange(of: scenePhase) { phase in
                if phase == .inactive {
                    UIApplication.shared.isIdleTimerDisabled = false
                    saveTime()
                }
            }
        
    }
    
    private func keepScreenOn() {
        UIApplication.shared.isIdleTimerDisabled = true
    }
    private func dispTime(mustRedo: Bool) -> String {
        if mustRedo == true {
            job.setHours(new:  resumeTimer.setNewHours(currentTime: start, endTime: timeClosed))
            job.setMins(new: resumeTimer.setNewMins(currentTime: start, endTime: timeClosed))
            job.setSeconds(new: resumeTimer.setNewSeconds(currentTime: start, endTime: timeClosed))
        }
        return String(format: "%02d:%02d:%02d", job.hours, job.mins, job.seconds)
    }
    private func stopTimer(){
        UIApplication.shared.isIdleTimerDisabled = false
        timer.upstream.connect().cancel()
    }
    private func shouldProceed() -> Bool{
        if faceUp == true {
            if manager.isGyroActive == false {print("not active tag 4")}
            return false
        }
        return true
    }
}
    

struct JobTimer_Previews: PreviewProvider{
    static var job = Job.sampleData[0]
    static var previews: some View{
        JobTimer(timeClosed: .constant(Date.now), job:.constant(job), jobs: .constant(Job.sampleData), mustRedo: .constant(false), manager: .constant(CMMotionManager()), saveTime: {})
    }
}
