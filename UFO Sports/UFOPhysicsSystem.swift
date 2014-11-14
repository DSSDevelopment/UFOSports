//
//  UFOPhysicsSystem.swift
//  UFO Sports
//
//  Created by Derek Sanchez on 11/14/14.
//  Copyright (c) 2014 Dramatech. All rights reserved.
//

public final class UFOPhysicsSystem: UFOSystem
{
    
    override public func accepts(entity: UFOEntity) -> Bool
    {
        if(entity.has(UFOPhysicsBodyComponent) && entity.has(UFOPositionComponent)) { return true }
        return false
    }
    
}
