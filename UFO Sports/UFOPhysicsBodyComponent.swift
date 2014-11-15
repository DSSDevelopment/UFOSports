//
//  UFOPhysicsBodyComponent.swift
//  UFO Sports
//
//  Created by Cameron Paul on 11/14/14.
//  Copyright (c) 2014 Dramatech. All rights reserved.
//

public final class UFOPhysicsBodyComponent: UFOComponent {
    
    public func type() -> String
    {
        return UFOPhysicsBodyComponent.type()
    }
    
    public class func type() -> String
    {
        return "UFOPhysicsBodyComponent"
    }
    
    var speed: Float = 0.0
    var acceleration: Float = 0.0
    var collisionRadius: Double = 0.0
    var mass = 0
    
}