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

func getPointsOfWindow(window:Window) -> [(CGFloat, CGFloat)] {
    let halfWidth = (window.size.width / 2)
    let halfHeight = (window.size.height / 2)
    let xRange = (window.position.x - halfWidth, window.position.x + halfWidth)
    let yRange = (window.position.y - halfHeight, window.position.y + halfHeight)
    return [xRange, yRange]
}

class GameScene: SKScene {
    
    let playerOne:Player = Player()
    var buildings:[Building] = []
    let gameFont: String = "TamilSangamMN-Bold"
    let timer: TimerLabel = TimerLabel(fontNamed: "TamilSangamMN-Bold")
    
    func buildingCollapsed(name: String, state: String) {
        print("BUILDING COLLAPSED!!! name:", name, "state:", state)
    }

    override func didMove(to view: SKView) {
        // Create Background
        let background = SKSpriteNode(imageNamed: "SidewalkBackground1")
        background.zPosition = 0
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        addChild(background)
        
        // Create Buildings
        let building1:Building = Building(scene: self)
        let building2:Building = Building(scene: self)
        building1.position = CGPoint(x: size.width * 0.5, y: size.height * 0.45)
        building1.zPosition = 1
        building1.name = "Building1"
        addChild(building1)
        buildings.append(building1)
        
        building2.position = CGPoint(x: size.width * 0.3, y: size.height * 0.45)
        building2.zPosition = 1
        building2.name = "Building2"
        addChild(building2)
        buildings.append(building2)
        
        // Create Player
        playerOne.position = CGPoint(x: size.width * 0.8, y: size.height * 0.4)
        playerOne.zPosition = 3
        playerOne.isUserInteractionEnabled = false
        addChild(playerOne)
        
        // Create Timer
        timer.fontSize = 20
        timer.fontColor = SKColor.magenta
        timer.position = CGPoint(x: 70, y: size.height - 30)
        addChild(timer)
        timer.startWithDuration(duration: 30)
    }
    
    override func update(_ currentTime: TimeInterval) {
        timer.update()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touchCount = touches.count
        guard let touch = touches.first else {
            return
        }
        let tapCount = touch.tapCount
        
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
            default: // double tap
                let positionInScene = touch.location(in: self)
                let touchedNode = self.atPoint(positionInScene)
                if touchedNode is Window {
                    let window = touchedNode as! Window
                    window.takeDamage()
                }
                playerOne.punch()
        }
        

    }
}
