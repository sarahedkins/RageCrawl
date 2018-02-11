//
//  Player.swift
//  RageCrawl
//
//  Created by Sarah Edkins on 5/28/17.
//  Copyright © 2017 Sarah Edkins. All rights reserved.
//

import UIKit
import SpriteKit


class Player: SKSpriteNode {
    
    let moveSpeed = 1.0
    let walkSpeed = 0.18
    let punchSpeed = 0.08
    
    init() {
        let texture = SKTexture(imageNamed: "Lizzie1.png")
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    func walkToDest(dest: CGPoint) {
        let textureAtlas = SKTextureAtlas(named: "Lizzie")
        let frames = ["Lizzie1", "Lizzie2",].map { textureAtlas.textureNamed($0) }
        let animate = SKAction.animate(with: frames, timePerFrame: walkSpeed)
        let walk = SKAction.repeat(animate, count: Int(moveSpeed / walkSpeed) - 2)
        let move = SKAction.move(to: dest, duration: moveSpeed)
        let group = SKAction.group([walk, move])
        self.run(group)
    }
    
    func punch() {
        let textureAtlas = SKTextureAtlas(named: "LizziePunch")
        let frames = ["liz_punch1", "liz_punch3", "liz_punch3", "liz_punch3", "liz_punch4", "liz_punch4"].map { textureAtlas.textureNamed($0) }
        let animate = SKAction.animate(with: frames, timePerFrame: punchSpeed)
        self.run(animate)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
