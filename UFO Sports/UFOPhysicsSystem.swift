//
//  UFOPhysicsSystem.swift
//  UFO Sports
//
//  Created by Derek Sanchez on 11/14/14.
//  Copyright (c) 2014 Dramatech. All rights reserved.
//

import Foundation

public final class UFOPhysicsSystem: UFOSystem
{
    var physicsBodies = [UFOPhysicsBodyComponent]()
    var positions = [UFOPositionComponent]()
    
    override public init() {
        super.init()
        self.updatePhase = .Physics
    }
    
    override public func accepts(entity: UFOEntity) -> Bool
    {
        if(entity.has(UFOPhysicsBodyComponent) && entity.has(UFOPositionComponent)) { return true }
        return false
    }
    
    override public func add(entity: UFOEntity)
    {
        super.add(entity)
        if(self.accepts(entity)){
        physicsBodies.append(self.getPhysicsBodyForEntity(entity))
        positions.append(self.getPositionBodyForEntity(entity))
        }
    }
    
    override public func update()
    {
        for id in 0 ..< entities.count
        {
            var position            = self.getPositionBodyForEntity(entities[id])
            var physicsBody         = physicsBodies[id]
            var lastx               = position.x
            var lasty               = position.y
            var speed: Float        = physicsBody.speed
            var acceleration        = physicsBody.acceleration
            var lastRotation        = position.rotation
            
            speed = Float(speed) + Float(acceleration)
            var xDirection: Double = cos(lastRotation)
            var yDirection: Double = sin(lastRotation)
            
            var xVelocity: Double = xDirection * Double(speed)
            var yVelocity: Double = yDirection * Double(speed)

            position.x += xVelocity * 1/60.0
            position.y += yVelocity * 1/60.0
            
            
        }
    }
    
    func getPhysicsBodyForEntity(entity: UFOEntity) -> UFOPhysicsBodyComponent
    {
        let physicsBody = entity.get(UFOPhysicsBodyComponent)!
        return physicsBody
    }
    
    func getPositionBodyForEntity(entity: UFOEntity) -> UFOPositionComponent
    {
        let positionComponent = entity.get(UFOPositionComponent)!
        return positionComponent
    }
    
    
    
}
