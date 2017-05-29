//
//  Player.swift
//  RageCrawl
//
//  Created by Sarah Edkins on 5/28/17.
//  Copyright © 2017 Sarah Edkins. All rights reserved.
//

import UIKit
import SpriteKit

//class Player: SKSpriteNode {
//    
//    // setup for walk animation
//    let atlas = SKTextureAtlas(named: "Lizzie")
//    let liz1 = atlas.textureNamed("Lizzie1.png")
//    let liz2 = atlas.textureNamed("Lizzie2.png")
//    let lizAnimation = SKAction.animate(with: textures, timePerFrame: 0.5)
//    
//    let textures = [liz1, liz2]
//    
//    init() {
//        let texture = SKTexture(imageNamed: "Lizzie1.png")
//        super.init(texture: texture, color: SKColor.clear, size: texture.size())
//        self.name = "Player"
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//    
//    func fireBullet(scene: SKScene){
//        
//    }
//    
//    func walk() {
//        self.run(SKAction.repeatForever(lizAnimation))
//    }
//    
//}


class Player: SKSpriteNode {
    
    init() {
        let texture = SKTexture(imageNamed: "Lizzie1.png")
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    func walkToDest(dest: CGPoint) {
        let textureAtlas = SKTextureAtlas(named: "Lizzie")
        let frames = ["Lizzie1", "Lizzie2",].map { textureAtlas.textureNamed($0) }
        let animate = SKAction.animate(with: frames, timePerFrame: 0.18)
        let walk = SKAction.repeatForever(animate)
        let move = SKAction.move(to: dest, duration: 1.0)
        let group = SKAction.group([walk, move]);
        self.run(group, withKey: "walking")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
