//
//  Building.swift
//  RageCrawl
//
//  Created by Sarah Edkins on 2/8/18.
//  Copyright © 2018 Sarah Edkins. All rights reserved.
//

import UIKit
import SpriteKit


class Building: SKSpriteNode {
    
    var health:Int = 100
    let numWindows:Int = 4
    let windowStartX:Int = -23
    let WindowStartY:Int = -23
    let windowCenterSpace = 49
    let windowVerticalSpace = 55
    var windows:[Window] = []
    
    init() {
        let texture = SKTexture(imageNamed: "BrickBuildingWithTrim.png")
        super.init(texture: texture, color: .clear, size: texture.size())
        
        // Set up windows on the building
        var currWindowX = windowStartX
        var currWindowY = WindowStartY
        var lastMovedX = false
        var movedXLeftLastTime = true
        for idx in 1...numWindows {
            let window:Window = Window(building: self)
            window.position = CGPoint(x: currWindowX, y: currWindowY)
            window.zPosition = 1
            window.name = "Window" + String(idx)
            addChild(window)
            windows.append(window)
            if lastMovedX {
                currWindowY += windowVerticalSpace
                lastMovedX = false
            } else {
                if movedXLeftLastTime {
                    currWindowX += windowCenterSpace
                    movedXLeftLastTime = false
                } else {
                    currWindowX -= windowCenterSpace
                    movedXLeftLastTime = true
                }
                lastMovedX = true
            }
        }
    }
    
    func takeDamage() {
        // TODO - update sprite with more damaged one
        print("BUILDING TAKING DAMAGE!")
    }
    
    func collapse() {
        print("BUILDING SHOULD FALL NOW!!")
        
        // TODO - atlas of smoking clouds and rumble at base
        // translate building sprite down and hidden somehow
        let smokeSpeed = 1.0
        
        let textureAtlas = SKTextureAtlas(named: "Smoke")
        let frames = ["smoke1", "smoke2", "smoke3", "smoke2", "smoke3", "smoke4", "smoke5"].map { textureAtlas.textureNamed($0) }
        let animate = SKAction.animate(with: frames, timePerFrame: smokeSpeed)
        self.run(animate)
    }
    
    func windowUpdate(state: String) {
        switch state {
        case "smallcrack":
            health -= 5
        case "bigcrack":
            health -= 8
        case "onfire":
            health -= 12
        default:
            print("windowUpdate default case")
        }
        if health <= 0 {
            collapse()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
