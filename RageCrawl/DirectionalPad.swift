//
//  DirectionalPad.swift
//  RageCrawl
//
//  Created by Sarah Edkins on 5/29/17.
//  Copyright © 2017 Sarah Edkins. All rights reserved.
//

import UIKit
import SpriteKit

class DirectionalPad: SKSpriteNode {
    
    init() {
        super.init(texture: nil, color: UIColor.blue, size: CGSize(width: 100, height: 100))
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch!")
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        print(touchLocation)
    }
    
}
