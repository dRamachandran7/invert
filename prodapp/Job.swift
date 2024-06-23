//
//  Task.swift
//  prodapp
//
//  Created by Dhruva Ramachandran on 1/8/24.
//

import Foundation
import SwiftUI
import CoreLocation

struct Job: Hashable, Codable {
    var name: String
    var hours: Int
    var mins: Int
    var seconds: Int
    var breakMins: Int
    var breakHours: Int
    var breakSecs: Int
    
    init(name: String, hours: Int, mins: Int, secs: Int, breakMins: Int, breakHours: Int, breakSecs: Int){
        self.name = name
        self.hours = hours
        self.mins = mins
        seconds = secs
        self.breakMins = breakMins
        self.breakHours = breakHours
        self.breakSecs = breakSecs
    }
    mutating func setHours (new: Int){
        self.hours = new
    }
    mutating func setMins (new: Int){
        self.mins = new
    }
    mutating func setSeconds (new: Int){
        self.seconds = new
    }
    mutating func setBreakHours (new: Int){
        self.breakHours = new
    }
    mutating func setBreakMins (new: Int){
        self.breakMins = new
    }
    mutating func setBreakSecs (new: Int){
        self.breakSecs = new
    }
}

extension Job{
    static let sampleData: [Job] = [
        Job(name: "This is the first task", hours: 1, mins: 3, secs: 41, breakMins: 1, breakHours: 0, breakSecs: 0),
        Job(name: "This is the second task", hours: 0, mins: 25, secs: 0, breakMins: 5, breakHours: 0, breakSecs: 0)
    ]
}
