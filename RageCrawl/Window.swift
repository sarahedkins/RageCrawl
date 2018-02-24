//
//  Window.swift
//  RageCrawl
//
//  Created by Sarah Edkins on 2/11/18.
//  Copyright © 2018 Sarah Edkins. All rights reserved.
//

import UIKit
import SpriteKit


class Window: SKSpriteNode {
    
//    var observers: [Observer] = []
//    var state: String {
//        didSet {
//            notify()
//        }
//    }
//    init(state: String) {
//        self.state = state
//    }
//    func attach(observer: Observer) {
//        observers.append(observer)
//    }
//    func notify() {
//        for observer in observers {
//            observer.update()
//        }
//    }
    
    var currentDamage = "None"
    let imageNames = ["WindowCrack1", "WindowCrack2"]
    var onFire = false
    let flickerRate = 0.1
    let flickerRepeat = 10
    var parentBuilding: Building
    
    init(building: Building) {
        let texture = SKTexture(imageNamed: "Window.png")
        parentBuilding = building
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    func notifyBuilding(state: String) {
        parentBuilding.windowUpdate(state: state)
    }
    
    func takeDamage() {
        
        if currentDamage == "onfire" {
            return
        }
        
        if currentDamage == "None" {
            self.texture = SKTexture(imageNamed: imageNames[0])
            currentDamage = "smallcrack"
            notifyBuilding(state: currentDamage)
        } else if currentDamage == "smallcrack" {
            self.texture = SKTexture(imageNamed: imageNames[1])
            currentDamage = "bigcrack"
            notifyBuilding(state: currentDamage)
        } else {
            let textureAtlas = SKTextureAtlas(named: "WindowCracking")
            let frames = ["WindowFire1", "WindowFire2"].map { textureAtlas.textureNamed($0) }
            let animate = SKAction.animate(with: frames, timePerFrame: flickerRate)
            let flicker = SKAction.repeatForever(animate)
            self.run(flicker)
            currentDamage = "onfire"
            notifyBuilding(state: currentDamage)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
