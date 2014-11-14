//
//  GameScene.swift
//  UFO Sports
//
//  Created by Derek Sanchez on 11/13/14.
//  Copyright (c) 2014 Dramatech. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var initialized = false
    var entityFactory = UFOEntityFactory()
    var entityManager = UFOEntityManager()
    var renderingSystem = UFORenderingSystem()
    var updateObservers = [UFOUpdatable]()
    
    override func didMoveToView(view: SKView)
    {
        if initialized == false
        {
            entityManager.scene = self
            updateObservers.append(entityManager)
            entityManager.addSystem(renderingSystem)
            entityFactory.createUFOPlayerWithEntityManager(entityManager, position: CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)))
            entityFactory.createUFOPlayerWithEntityManager(entityManager, position: CGPoint(x:CGRectGetMidX(self.frame)+65.0, y:CGRectGetMidY(self.frame)+20.0))
            initialized = true
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        /* Called when a touch begins */
        
    }
   
    override func update(currentTime: CFTimeInterval)
    {
        for updateObserver in updateObservers
        {
            updateObserver.update()
        }
    }
}
