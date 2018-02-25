//
//  TimerLabel.swift
//  RageCrawl
//
//  Created by Sarah Edkins on 2/25/18.
//  Copyright © 2018 Sarah Edkins. All rights reserved.
//


import SpriteKit

class TimerLabel: SKLabelNode {
    
    var endTime:NSDate!
    
    func update() {
        let timeLeftInteger = Int(timeLeft())
        text = "Time: " + String(timeLeftInteger)
    }
    
    func startWithDuration(duration: TimeInterval) {
        let timeNow = NSDate()
        endTime = timeNow.addingTimeInterval(duration)
    }
    
    func hasFinished() -> Bool {
        return timeLeft() == 0
    }
    
    private func timeLeft() -> TimeInterval {
        let remainingSeconds = endTime.timeIntervalSinceNow
        return max(remainingSeconds, 0)
    }
}
