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
    let smokeSpeed = 0.5
    let puffSpeed = 0.4
    let buildingImage = "BrickBuildingWithTrim.png"
    var parentScene: GameScene

    init(scene: GameScene) {
        let texture = SKTexture(imageNamed: buildingImage)
        parentScene = scene
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
    
    func notifyGameScene(state: String) {
        parentScene.buildingCollapsed(name: self.name!, state: state)
    }
    
    func takeDamage() {
        // TODO - update sprite with more damaged one
        print("BUILDING TAKING DAMAGE!")
    }
    
    func collapse() {
        let textureAtlas = SKTextureAtlas(named: "Smoke")
        let frames = ["smoke1", "smoke2", "smoke3", "smoke2", "smoke3", "smoke4", "smoke5"].map { textureAtlas.textureNamed($0) }
        let frames_puffing = ["smoke4", "smoke5"].map { textureAtlas.textureNamed($0) }
        let billow = SKAction.animate(with: frames, timePerFrame: smokeSpeed)
        let puffing = SKAction.animate(with: frames_puffing, timePerFrame: puffSpeed)
        let repeatPuffing = SKAction.repeat(puffing, count: 5)
        let group = SKAction.sequence([billow,repeatPuffing])
        let texture = SKTexture(imageNamed: buildingImage)
        let smokenode = SKSpriteNode(texture: texture, color: .clear, size: texture.size())
        smokenode.zPosition = 2
        self.addChild(smokenode)
        smokenode.run(group, completion: {
            () -> Void in
                self.notifyGameScene(state: "collapse")
                smokenode.removeFromParent()
                for window in self.windows {
                    window.removeFromParent()
                }
                self.texture = SKTexture(imageNamed: "brickbuildingrubble1")
        })
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
