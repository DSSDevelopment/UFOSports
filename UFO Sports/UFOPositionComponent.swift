//
//  UFOPosition.swift
//  UFO Sports
//
//  Created by Derek Sanchez on 11/13/14.
//  Copyright (c) 2014 Dramatech. All rights reserved.
//

public final class UFOPositionComponent: UFOComponent
{
    public func type() -> String
    {
        return UFOPositionComponent.type()
    }
    
    public class func type() -> String
    {
        return "UFOPositionComponent"
    }
    
    public var x: Double            = 0.0
    public var y: Double            = 0.0
    public var rotation: Double     = 0.0
    
    public init(x: Double, y: Double, rotation: Double)
    {
        self.x = x
        self.y = y
        self.rotation = rotation
    }
}
