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
    

//    var facingRight = true
    let tempPlayer:Player = Player()

    override func didMove(to view: SKView) {
        backgroundColor = SKColor.gray

        tempPlayer.position = CGPoint(x: size.width * 0.8, y: size.height * 0.5)
        addChild(tempPlayer)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)

 
        // if touch behind lizzie, turn her around
        var offset : CGPoint

        offset = touchLocation - tempPlayer.position
        
        let realDest = touchLocation
        tempPlayer.walkToDest(dest: realDest)
        
//        // if touch behind lizzie, turn her around
//        var offset : CGPoint
//        if (facingRight) {
//            lizzie_right.removeAllActions()
//            offset = touchLocation - lizzie_right.position
//        } else {
//            lizzie_left.removeAllActions()
//            offset = touchLocation - lizzie_left.position
//        }
//        
//        if (offset.x < 0 && facingRight) { // swap to face left
//            facingRight = false
//            lizzie_left.position = lizzie_right.position
//            lizzie_right.run(SKAction.sequence([remove]))
//            addChild(lizzie_left)
//            
//        } else if (offset.x >= 0 && !facingRight) { // swap to face right
//            facingRight = true
//            lizzie_right.position = lizzie_left.position
//            lizzie_left.run(SKAction.sequence([remove]))
//            addChild(lizzie_right)
//        }
//        
//        let realDest = touchLocation
//        facingRight ?
//            moveSpriteToDest(sprite: lizzie_right, dest: realDest) :
//            moveSpriteToDest(sprite: lizzie_left, dest: realDest)
    }
}
