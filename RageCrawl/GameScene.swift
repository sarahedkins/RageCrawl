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


class GameScene: SKScene {
    
    let playerOne:Player = Player()
//    let dPad:DirectionalPad = DirectionalPad()
//    let buttonRight:Button = Button()


    override func didMove(to view: SKView) {
        backgroundColor = SKColor.gray
        playerOne.position = CGPoint(x: size.width * 0.8, y: size.height * 0.5)
        addChild(playerOne)
        
//        dPad.position = CGPoint(x: size.width * 0.1, y: size.height * 0.1)
//        addChild(dPad)
        
//        buttonRight.position = CGPoint(x: size.width * 0.9, y: size.height * 0.1)
//        addChild(buttonRight)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        
        playerOne.removeAllActions()
        
        var multiplierForDirection : CGFloat
        if (touchLocation.x <= self.frame.midX) {
            multiplierForDirection = -1.0
        } else {
            multiplierForDirection = 1.0
        }
        
        playerOne.xScale = fabs(playerOne.xScale) * multiplierForDirection
        playerOne.walkToDest(dest: touchLocation)
        
    }
}
