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
    
    init() {
        let texture = SKTexture(imageNamed: "brickbuilding1.png")
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    // TODO method for getting hit takeDamage, update image to look worse
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
