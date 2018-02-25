//
//  DamageLabel.swift
//  RageCrawl
//
//  Created by Sarah Edkins on 2/25/18.
//  Copyright © 2018 Sarah Edkins. All rights reserved.
//

import SpriteKit

class DamageLabel: SKLabelNode {
    
    var endTime:NSDate!
    
    func update(amount: Int) {
        let timeLeftInteger = Int(timeLeft())
        text = "Damage: " + String(timeLeftInteger)
    }
    
    func startWithDuration(duration: TimeInterval) {
        let timeNow = NSDate()
        endTime = timeNow.addingTimeInterval(duration)
    }
    
    func hasFinished() -> Bool {
        return timeLeft() == 0
    }
    
    private func damageLeft() -> TimeInterval {
        let remainingSeconds = endTime.timeIntervalSinceNow
        return max(remainingSeconds, 0)
    }
}
