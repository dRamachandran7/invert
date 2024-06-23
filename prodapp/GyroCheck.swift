//
//  GyroCheck.swift
//  prodapp
//
//  Created by Dhruva Ramachandran on 2/8/24.
//

import Foundation
import CoreMotion
/*
class GyroCheck {
    let manager = CMMotionManager()
   
    func checkPhoneTurn () -> String {
        var startTime = Date.now
        var totalRotation = 0.0
        
        manager.startGyroUpdates()
        manager.gyroUpdateInterval = 0.1
        manager.startGyroUpdates(to: OperationQueue.current!){ (data, Error) in
            let current = Date.now
            var dt = Calendar.current.dateComponents([.second], from: current, to: startTime)
            let dTheta = Double(self.manager.gyroData?.rotationRate.y ?? 0) * Double(dt.second ?? 0)
            
            totalRotation += dTheta
            if(totalRotation >= 3.14){
                return true
            }
        }
        
    }
}*/

