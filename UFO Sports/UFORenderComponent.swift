//
//  RenderComponent.swift
//  UFO Sports
//
//  Created by Derek Sanchez on 11/13/14.
//  Copyright (c) 2014 Dramatech. All rights reserved.
//

import SpriteKit

public final class UFORenderComponent: UFOComponent
{
    public func type() -> String
    {
        return UFORenderComponent.type()
    }
    
    
    public class func type() -> String
    {
        return "UFORenderComponent"
    }
    
    var node: SKSpriteNode
    
    init (node: SKSpriteNode)
    {
        self.node = node
        self.node.xScale = kSpriteScale
        self.node.yScale = kSpriteScale
    }
}
