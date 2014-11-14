//
//  UFORenderingSystem.swift
//  UFO Sports
//
//  Created by Derek Sanchez on 11/13/14.
//  Copyright (c) 2014 Dramatech. All rights reserved.
//

import Foundation
import SpriteKit

public class UFORenderingSystem: UFOSystem
{
    var nodes = [SKSpriteNode]()
    var positions = [UFOPositionComponent]()
    
    override public init() {
        super.init()
        self.updatePhase = .Render
    }
    
    override public func accepts(entity: UFOEntity) -> Bool {
        if (entity.has(UFORenderComponent) && entity.has(UFOPositionComponent)) { return true }
        return false
    }
    
    override public func add(entity: UFOEntity)
    {
        super.add(entity)
        nodes.append(self.getNodeForEntity(entity))
        positions.append(entity.get(UFOPositionComponent)!)
        self.entityManager.scene!.addChild(self.getNodeForEntity(entity))
    }
    
    override public func update()
    {
        for id in 0 ..< entities.count
        {
            var position = positions[id]
            var node = nodes[id]
            node.position.x = CGFloat(position.x)
            node.position.y = CGFloat(position.y)
        }
    }
    
    func getNodeForEntity(entity: UFOEntity) -> SKSpriteNode
    {
        var renderComponent = entity.get(UFORenderComponent)
        return renderComponent!.node
        
    }
    
    
}
