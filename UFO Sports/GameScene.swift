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
    var inputSystem = UFOPlayerControlSystem()
    var updateObservers = [UFOUpdatable]()
    
    //Camera system
    var world = SKNode()
    var camera = SKNode()
    var localPlayer: UFOEntity?
    var UINode = SKNode()
    
    // MARK: Analog Stick Properties
    
    var appleNode: SKSpriteNode?
    let moveAnalogStick: AnalogStick = AnalogStick()
    let rotateAnalogStick: AnalogStick = AnalogStick()

    
    override func didMoveToView(view: SKView)
    {
        
        if initialized == false
        {
            self.anchorPoint = CGPointMake(0.5, 0.5)
            self.addChild(self.world)
            self.camera.name = "camera"
            self.world.addChild(self.camera)
            self.UINode.position = CGPointMake(0.0, 0.0)
            self.UINode.zPosition = 10000
            self.world.addChild(self.UINode)
            let backgroundNode = SKSpriteNode(imageNamed: "Background.png")
            backgroundNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
            self.world.addChild(backgroundNode)
            let bgDiametr: CGFloat = 120
            let thumbDiametr: CGFloat = 60
            let joysticksRadius = bgDiametr / 2
            moveAnalogStick.bgNodeDiametr = bgDiametr
            moveAnalogStick.thumbNodeDiametr = thumbDiametr
            moveAnalogStick.position = CGPointMake(joysticksRadius + 60 - (self.frame.width/2), joysticksRadius + 145 - (self.frame.height/2))
            moveAnalogStick.delagate = self
            self.UINode.addChild(moveAnalogStick)
            rotateAnalogStick.bgNodeDiametr = bgDiametr
            rotateAnalogStick.thumbNodeDiametr = thumbDiametr
            rotateAnalogStick.position = CGPointMake(CGRectGetMaxX(self.frame) - joysticksRadius - 60, joysticksRadius + 145)
            rotateAnalogStick.delagate = self
            self.UINode.addChild(rotateAnalogStick)
            entityManager.scene = self
            entityManager.world = self.world
            updateObservers.append(entityManager)
            entityManager.addSystem(renderingSystem)
            entityManager.addSystem(physicsSystem)
            entityManager.addSystem(inputSystem)
            entityFactory.createUFOPlayerWithEntityManager(entityManager, position: CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)))
            entityFactory.createUFONPCWithEntityManager(entityManager, position: CGPoint(x:CGRectGetMidX(self.frame)-125.0, y:CGRectGetMidY(self.frame)+20.0))
            initialized = true
        }
        
        
  
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        /* Called when a touch begins */
        super.touchesBegan(touches, withEvent: event)
        if let touch = touches.anyObject() as? UITouch {
            //appleNode?.position = touch.locationInNode(self)
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
    
    override func didFinishUpdate()
    {
        self.centerOnNode(self.world.childNodeWithName("camera")!)
    }
    
    func centerOnNode(node: SKNode)
    {
        let cameraPositionInScene: CGPoint = node.scene!.convertPoint(node.position, fromNode: node.parent!)
        node.parent?.position = CGPointMake(node.parent!.position.x, node.parent!.position.y)
    }
    
    // MARK: Analog Stick Temporary Methods
    
    func moveAnalogStick(analogStick: AnalogStick, velocity: CGPoint, angularVelocity: Float)
    {
        //if self.inputSystem {
            if analogStick.isEqual(moveAnalogStick) {
                //aN.position = CGPointMake(aN.position.x + (velocity.x * 0.12), aN.position.y + (velocity.y * 0.12))
                self.inputSystem.acceleratePlayer(velocity)
            } else if analogStick.isEqual(rotateAnalogStick) {
                //aN.zRotation = CGFloat(angularVelocity)
            }
        //}
    }
}
