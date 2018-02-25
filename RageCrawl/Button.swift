//
//  Button.swift
//  RageCrawl
//
//  Created by Sarah Edkins on 5/29/17.
//  Copyright © 2017 Sarah Edkins. All rights reserved.
//

import UIKit
import SpriteKit

class Button: SKSpriteNode {
    
    init() {
        super.init(texture: nil, color: UIColor.red, size: CGSize(width: 50, height: 50))
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch!")
    }
    
}
