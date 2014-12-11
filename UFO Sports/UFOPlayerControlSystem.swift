//
//  UFOPlayerControlSystem.swift
//  UFO Sports
//
//  Created by Derek Sanchez on 12/11/14.
//  Copyright (c) 2014 Dramatech. All rights reserved.
//

import Foundation
import CoreGraphics

public final class UFOPlayerControlSystem: UFOSystem {
    
    var playerPositionComponent: UFOPositionComponent?
    var playerPhysicsBodyComponent: UFOPhysicsBodyComponent?
    var nextPlayerPosition: CGPoint = CGPointMake(0.0, 0.0)
    var initialized: Bool = false
    
    override public init() {
        super.init()
        self.updatePhase = .Input
    }
    
    override public func accepts(entity: UFOEntity) -> Bool
    {
        if(entity.has(UFOLocalPlayerComponent) && entity.has(UFOPhysicsBodyComponent) && entity.has(UFOPositionComponent)) {
            return true
        }
        return false
    }
    
    override public func add(entity: UFOEntity)
    {
        super.add(entity)
        if(accepts(entity)){
        playerPhysicsBodyComponent = entity.get(UFOPhysicsBodyComponent)
        playerPositionComponent = entity.get(UFOPositionComponent)
        }
    }
    
    override public func update() {
        if(initialized){
        self.playerPositionComponent!.x = Double(self.nextPlayerPosition.x)
        self.playerPositionComponent!.y = Double(self.nextPlayerPosition.y)
        }
    }
    
    public func newPlayerPosition(position: CGPoint) {
        self.nextPlayerPosition = position
    }
    
    public func acceleratePlayer(velocity: CGPoint) {
        if(initialized == false){ initialized = true }
        self.nextPlayerPosition = CGPointMake(CGFloat(self.playerPositionComponent!.x) + (velocity.x * 0.12), CGFloat(self.playerPositionComponent!.y) + (velocity.y * 0.12))
    }
    
}
