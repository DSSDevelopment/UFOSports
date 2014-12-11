//
//  GameScene.swift
//  UFO Sports
//
//  Created by Derek Sanchez on 11/13/14.
//  Copyright (c) 2014 Dramatech. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, AnalogStickProtocol {
    var initialized = false
    var entityFactory = UFOEntityFactory()
    var entityManager = UFOEntityManager()
    var renderingSystem = UFORenderingSystem()
    var physicsSystem = UFOPhysicsSystem()
    var updateObservers = [UFOUpdatable]()
    
    // MARK: Analog Stick Properties
    
    var appleNode: SKSpriteNode?
    let moveAnalogStick: AnalogStick = AnalogStick()
    let rotateAnalogStick: AnalogStick = AnalogStick()

    
    override func didMoveToView(view: SKView)
    {
        
        let bgDiametr: CGFloat = 120
        let thumbDiametr: CGFloat = 60
        let joysticksRadius = bgDiametr / 2
        moveAnalogStick.bgNodeDiametr = bgDiametr
        moveAnalogStick.thumbNodeDiametr = thumbDiametr
        moveAnalogStick.position = CGPointMake(joysticksRadius + 60, joysticksRadius + 145)
        moveAnalogStick.delagate = self
        self.addChild(moveAnalogStick)
        rotateAnalogStick.bgNodeDiametr = bgDiametr
        rotateAnalogStick.thumbNodeDiametr = thumbDiametr
        rotateAnalogStick.position = CGPointMake(CGRectGetMaxX(self.frame) - joysticksRadius - 60, joysticksRadius + 145)
        rotateAnalogStick.delagate = self
        self.addChild(rotateAnalogStick)
        // apple
        appleNode = SKSpriteNode(imageNamed: "apple")
        if let aN = appleNode {
            aN.physicsBody = SKPhysicsBody(texture: aN.texture, size: aN.size)
            aN.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
            aN.physicsBody?.affectedByGravity = false;
            self.insertChild(aN, atIndex: 0)
        }
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        addOneApple()
        
        
        
        if initialized == false
        {
            entityManager.scene = self
            updateObservers.append(entityManager)
            entityManager.addSystem(renderingSystem)
            entityManager.addSystem(physicsSystem)
            entityFactory.createUFOPlayerWithEntityManager(entityManager, position: CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)))
            entityFactory.createUFOPlayerWithEntityManager(entityManager, position: CGPoint(x:CGRectGetMidX(self.frame)+65.0, y:CGRectGetMidY(self.frame)+20.0))
            initialized = true
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        /* Called when a touch begins */
        super.touchesBegan(touches, withEvent: event)
        if let touch = touches.anyObject() as? UITouch {
            appleNode?.position = touch.locationInNode(self)
        }

        
        
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent)
    {
        
    }
   
    override func update(currentTime: CFTimeInterval)
    {
        for updateObserver in updateObservers
        {
            updateObserver.update()
        }
    }
    
    // MARK: Analog Stick Temporary Methods
    func addOneApple()->Void {
        let appleNode = SKSpriteNode(imageNamed: "apple");
        appleNode.physicsBody = SKPhysicsBody(texture: appleNode.texture, size: appleNode.size)
        appleNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        appleNode.physicsBody?.affectedByGravity = false;
        self.addChild(appleNode)
    }
    
    func moveAnalogStick(analogStick: AnalogStick, velocity: CGPoint, angularVelocity: Float) {
        if let aN = appleNode {
            if analogStick.isEqual(moveAnalogStick) {
                aN.position = CGPointMake(aN.position.x + (velocity.x * 0.12), aN.position.y + (velocity.y * 0.12))
            } else if analogStick.isEqual(rotateAnalogStick) {
                aN.zRotation = CGFloat(angularVelocity)
            }
        }
    }
}
