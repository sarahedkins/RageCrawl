//
//  GameScene.swift
//  RageCrawl
//
//  Created by Sarah Edkins on 5/28/17.
//  Copyright © 2017 Sarah Edkins. All rights reserved.
//

import SpriteKit

var liz : SKSpriteNode!
var lizWalkingFrames : [SKTexture]!

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

#if !(arch(x86_64) || arch(arm64))
    func sqrt(a: CGFloat) -> CGFloat {
        return CGFloat(sqrtf(Float(a)))
    }
#endif

extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint {
        return self / length()
    }
}

func getXRangeOfBuilding(building:Building) -> (CGFloat, CGFloat) {
    let halfWidth = (building.size.width / 2)
    return (building.position.x - halfWidth, building.position.x + halfWidth)
}

class GameScene: SKScene {
    
    let playerOne:Player = Player()
    let building1:Building = Building()
    let building2:Building = Building()
    var buildings:[Building] = []

    override func didMove(to view: SKView) {
        // backgroundColor = SKColor.gray
        let background = SKSpriteNode(imageNamed: "RageCrawlBackground1")
        background.zPosition = 0
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        addChild(background)
        
        // Create Buildings
        building1.position = CGPoint(x: size.width * 0.5, y: size.height * 0.45)
        building1.zPosition = 1
        addChild(building1)
        buildings.append(building1)
        
        building2.position = CGPoint(x: size.width * 0.3, y: size.height * 0.45)
        building2.zPosition = 1
        addChild(building2)
        buildings.append(building2)
        
        // Create Player
        playerOne.position = CGPoint(x: size.width * 0.8, y: size.height * 0.4)
        playerOne.zPosition = 2
        addChild(playerOne)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchCount = touches.count
        guard let touch = touches.first else {
            return
        }
        let tapCount = touch.tapCount
        
        print("touches", touchCount)
        print("taps", tapCount)
        
        switch tapCount {
            case 1:
                var touchLocation = touch.location(in: self)
                playerOne.removeAllActions()
                
                var multiplierForDirection : CGFloat
                if (touchLocation.x <= playerOne.position.x) {  // Note 'self.frame.midX' is middle of screen
                    multiplierForDirection = -1.0
                } else {
                    multiplierForDirection = 1.0
                }
                touchLocation.y = size.height * 0.4 // Fixed plane
                playerOne.xScale = fabs(playerOne.xScale) * multiplierForDirection
                playerOne.walkToDest(dest: touchLocation)
            default:
                playerOne.punch()
        }
        

    }
}
