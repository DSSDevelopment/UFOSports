//
//  UFOEntityFactory.swift
//  UFO Sports
//
//  Created by Derek Sanchez on 11/13/14.
//  Copyright (c) 2014 Dramatech. All rights reserved.
//

import Foundation
import SpriteKit

class UFOEntityFactory
{
    func createUFOPlayerWithEntityManager(entityManager: UFOEntityManager, position: CGPoint)
    {
        var entity = entityManager.createEntity()
        let ufotexture = SKTexture(imageNamed: "UFO")
        ufotexture.filteringMode = .Nearest
        var ufoNode = SKSpriteNode(texture: ufotexture)
        var renderComponent = UFORenderComponent(node: ufoNode)
        var position = UFOPositionComponent(x: Double(position.x), y: Double(position.y), rotation: 1)
        var physicsBody = UFOPhysicsBodyComponent()
        physicsBody.speed = 40.0
        entityManager.addComponentToEntity(renderComponent, entity: entity)
        entityManager.addComponentToEntity(position, entity: entity)
        entityManager.addComponentToEntity(physicsBody, entity: entity)
        entityManager.addEntity(entity)
    }
    
    func createUFONPCWithEntityManager(entityManager: UFOEntityManager, position: CGPoint)
    {
        var entity = entityManager.createEntity()
        let ufotexture = SKTexture(imageNamed: "UFO")
        ufotexture.filteringMode = .Nearest
        var ufoNode = SKSpriteNode(texture: ufotexture)
        var renderComponent = UFORenderComponent(node: ufoNode)
        var position = UFOPositionComponent(x: Double(position.x), y: Double(position.y), rotation: 1)
        var physicsBody = UFOPhysicsBodyComponent()
        physicsBody.speed = 40.0
        entityManager.addComponentToEntity(renderComponent, entity: entity)
        entityManager.addComponentToEntity(position, entity: entity)
        entityManager.addComponentToEntity(physicsBody, entity: entity)
        entityManager.addEntity(entity)
    }
}
