//
//  JobTimer2.swift
//  prodapp
//
//  Created by Dhruva Ramachandran on 2/26/24.
//

import SwiftUI
import CoreMotion
import UserNotifications
import AVFoundation

class JobTimer2 {
    @Published var job = Job(name: "placeholder", hours: 0, mins: 0, secs: 0, breakMins: 0, breakHours: 0, breakSecs: 0)
    @Published var manager = CMMotionManager()
    var player: AVAudioPlayer?
    var start = Date.now
    var hours = ""
    var time = ""
    var mins = ""
    var secs = ""
    var totalRotation = 0.0
    var faceUp = true
    var stopText = ""
    var count = 0
    var workTimeActive = true
    var isActive = false
    var end = Date.now
    var diff = 0.0
    var breakMins = ""
    
    
    
    
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.dismiss) var dismiss
    
    func startTime(newJob: Job) {
        hours = "\(newJob.hours)"
        mins = "\(newJob.mins)"
        manager.startGyroUpdates()
        isActive = true
        time = String(format: "%02d:%02d:%02d", job.hours, job.mins, job.seconds)
        keepScreenOn()
    }
    func dispWorkTime(job: Job, secsToAdd: Double) {
        
        if isActive == true {
            end = Calendar.current.date(byAdding: .minute, value: (Int(mins) ?? 0), to: start)!

            diff = end.timeIntervalSince1970-Date.now.timeIntervalSince1970 + secsToAdd
            
            if diff <= 0 {
                isActive = false
                mins = "000"
                return
            }
            let date = Date(timeIntervalSince1970: diff)
            let calendar = Calendar.current
            
            let hours = calendar.component(.hour, from: date)
            let mins = calendar.component(.minute, from: date)
            let secs = calendar.component(.second, from: date)
            
            time = String(format: "%02d:%02d", mins, secs)
        }
        
    }
    func dispBreakTime(job: Job) {
        
            end = Calendar.current.date(byAdding: .minute, value: job.breakMins, to: start)!
            diff = end.timeIntervalSince1970-Date.now.timeIntervalSince1970
            
            if diff <= 0 {
                isActive = false
                breakMins = "000"
                return
            }
            let date = Date(timeIntervalSince1970: diff)
            let calendar = Calendar.current
            
            
            let breakMins = calendar.component(.minute, from: date)
            let secs = calendar.component(.second, from: date)
            
            time = String(format: "%02d:%02d", breakMins, secs)
        
    }
    private func keepScreenOn() {
        UIApplication.shared.isIdleTimerDisabled = true
    }
    func checkNotifPermission(workTimeActive: Bool) {
        print("went to checkNotifPermission")
        let notifCenter = UNUserNotificationCenter.current()
        notifCenter.getNotificationSettings {setting in
            switch setting.authorizationStatus {
            case .authorized:
                self.dispatchNotif(workTimeActive: workTimeActive)
            case .denied:
                print("denied")
                return
            case .notDetermined:
                notifCenter.requestAuthorization(options: [.alert, .sound]){ didAllow, error in
                    if didAllow{
                        self.dispatchNotif(workTimeActive: workTimeActive)
                    }
                }
            default:
                print("went to default")
                return
            }
        }
    }
    func dispatchNotif(workTimeActive: Bool) {
        print("went to dispatchNotif")
        let title = "Time's up!"
        var bodyText = ""
        if workTimeActive { bodyText = "Time to take a break" }
        else { bodyText = "Time to get to work" }
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = bodyText
        content.sound = .default
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: Date())
        let mins = calendar.component(.minute, from: Date())
        let secs = calendar.component(.second, from: Date())
        
        var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)
        dateComponents.hour = hour
        dateComponents.minute = mins
        dateComponents.second = secs 
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: "timer-done", content: content, trigger: trigger)
        
        //UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request)
    }
    func playAlert() {
        print("went here")
        let path = Bundle.main.path(forResource: "level-up-191997", ofType:nil)!
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
