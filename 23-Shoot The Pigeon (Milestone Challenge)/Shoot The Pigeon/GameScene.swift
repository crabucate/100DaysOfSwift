//
//  GameScene.swift
//  Shoot The Pigeon
//
//  Created by Felix Leitenberger on 20.06.20.
//  Copyright © 2020 Felix Leitenberger. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var animals = ["blueBird", "brownBird", "butterfly", "chick", "cow", "dolphin", "donkey", "frog", "mamut", "mouse", "pig", "pigeon1", "pigeon2", "pigeon3", "sealion", "walrus"]
    
    var rowHeights: [CGFloat] = [150, 380, 640]
    
    var scheduledTimer: Timer!
    var gameTimer: Timer!
    var gameEnded = false
    
    var playerScoreLabel: SKLabelNode!
    var playerScore = 0 {
        didSet {
            playerScoreLabel.text = "Score: \(playerScore)"
        }
    }
    
    var timeRemainingLabel: SKLabelNode!
    
    var timeRemaining = 60 {
        
        didSet {
            timeRemainingLabel.text = "Seconds left: \(timeRemaining)"
            
            if timeRemaining <= 10 {
                timeRemainingLabel.fontColor = UIColor.red
                
            }
        }
    }
    
    
    override func didMove(to view: SKView) {
        
        createAnimals()
        
        scheduledTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(createAnimals), userInfo: nil, repeats: true)
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(setGameTimer), userInfo: nil, repeats: true)
        
        //Create score label node and add to scene
               playerScoreLabel = SKLabelNode(fontNamed: "Chalkduster")
               playerScoreLabel.text = "Score: 0"
               playerScoreLabel.position = CGPoint(x: 8, y: 8)
               playerScoreLabel.horizontalAlignmentMode = .left
               playerScoreLabel.fontSize = 48
               addChild(playerScoreLabel)
               
               //Create Time remaining label node and add to scene
               timeRemainingLabel = SKLabelNode(fontNamed: "Chalkduster")
               timeRemainingLabel.text = "Seconds remaining: 60"
               timeRemainingLabel.position = CGPoint(x: 8, y: 760)
               timeRemainingLabel.horizontalAlignmentMode = .left
               timeRemainingLabel.verticalAlignmentMode = .top
               timeRemainingLabel.fontSize = 24
               addChild(timeRemainingLabel)
    }
    
    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.position.x > 1200 || node.position.x < -100 {
                node.removeFromParent()
            }
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            let touchedNodes = nodes(at: touchLocation)
            
            for node in touchedNodes {
                if let name = node.name {
                    if name.contains("pigeon") {
                        node.removeFromParent()
                        let emitter = SKEmitterNode(fileNamed: "pigeonFire")!
                        emitter.position = node.position
                        addChild(emitter)
                        playerScore += (500 / Int(node.frame.size.width))
                    } else {
                        playerScore -= 10
                    }
                }
            }
        }
    }
    
    
    @objc func createAnimals() {
        
        // First row
        let randomAnimal = animals.randomElement() ?? "pigeon"
        let animal = SKSpriteNode(imageNamed: randomAnimal)
        animal.setScale(CGFloat.random(in: 0.3...1.0))
        animal.position = CGPoint(x: -100, y: rowHeights[0])
        animal.name = randomAnimal
        addChild(animal)
        
        // Secons row
        let randomAnimal2 = animals.randomElement() ?? "pigeon"
        let animal2 = SKSpriteNode(imageNamed: randomAnimal2)
        animal2.setScale(CGFloat.random(in: 0.3...1.0))
        animal2.position = CGPoint(x: 1124, y: rowHeights[1])
        animal2.name = randomAnimal2
        addChild(animal2)
        
        // Third row
        let randomAnimal3 = animals.randomElement() ?? "pigeon"
        let animal3 = SKSpriteNode(imageNamed: randomAnimal3)
        animal3.setScale(CGFloat.random(in: 0.3...1.0))
        animal3.position = CGPoint(x: -100, y: rowHeights[2])
        animal3.name = randomAnimal3
        addChild(animal3)
        
        let actionRight = SKAction.move(by: CGVector(dx: 1300, dy: 0), duration: 3)
        let actionLeft = SKAction.move(by: CGVector(dx: -1300, dy: 0), duration: 3)
        
        animal.run(actionRight)
        animal2.run(actionLeft)
        animal3.run(actionRight)
        
    }
    
    
    @objc func setGameTimer() {
        
        //Update timer remaining
        timeRemaining -= 1
        
        if timeRemaining == 0 {
            
            //Cancel schedule timer
            scheduledTimer.invalidate()
            
            //Cancel game timer
            gameTimer.invalidate()
            
            fatalError("Game over not implemented")
        }
        
    }
}
