//
//  ResumeTimer.swift
//  prodapp
//
//  Created by Dhruva Ramachandran on 2/6/24.
//

import Foundation

class ResumeTimer {
    func setNewHours (currentTime: Date, endTime: Date) -> Int{
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: endTime, to: currentTime)
        if let hours = components.hour {
            return hours
        }
        else {
            return 0
        }
    }
    func setNewMins (currentTime: Date, endTime: Date) -> Int{
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: endTime, to: currentTime)
        if let mins = components.minute {
            return mins
        }
        else {
            return 0
        }
    }
    func setNewSeconds (currentTime: Date, endTime: Date) -> Int{
        let calendar = Calendar.current
        let components = calendar.dateComponents([.second], from: endTime, to: currentTime)
        if let secs = components.second {
            return secs
        }
        else {
            return 0
        }
    }
}
