//
//  EntityManager.swift
//  UFO Sports
//
//  Created by Derek Sanchez on 11/13/14.
//  Copyright (c) 2014 Dramatech. All rights reserved.
//

import Foundation
import SpriteKit

public class UFOEntityManager
{
    final var entities                      = [UFOEntity]()
    final var entitiesByID                  = [Int64: UFOEntity]()
    
    final var systems                       = [UFOSystem]()
    final var systemsByPhase                = [UFOUpdatePhase: [UFOSystem]]()
    
    final var lowestUnassignedEid: Int64    = 1
    
    final weak var scene:                   GameScene?
    final weak var localPlayer:             SKNode?
    final weak var world:                   SKNode?
    
    public var paused                       = false
    var initialized                         = false
    //public var time                         = 0
    
    public init() {}
    
    //MARK: Entity Methods
    
    func generateNewEid() -> Int64
    {
        if (lowestUnassignedEid < INT64_MAX) {
            return lowestUnassignedEid++
        } else {
            for var i: Int64 = 1; i < INT64_MAX; i++ { return i }
        }
        return 0
    }
    
    func createEntity() -> UFOEntity
    {
        var eid: Int64      = self.generateNewEid()
        var entity          = UFOEntity().initWithEid(eid)
        
        return entity
    }
    
    func addEntity(entity: UFOEntity)
    {
        entitiesByID[entity.eid]   = entity
        
        for system in systems
        {
            system.add(entity)
        }
        
        entities.append(entity)

    }
    
    func removeEntity(entity: UFOEntity)
    {
        for i in 0 ..< systems.count
        {
            systems[i].remove(entity)
        }
        
        for i in 0 ..< entities.count
        {
            if entities[i] == entity
            {
                entities.removeAtIndex(i)
                break
            }
        }
    }
    
    public func entityById(id: Int64) -> UFOEntity?
    {
        return entitiesByID[id]
    }
    
    //MARK: Component and System Methods
    
    func addComponentToEntity(component: UFOComponent, entity: UFOEntity)
    {
        entity.put(component: component)
        entity.hasChanged = true
        
    }
    
    func addSystemToNotificationsList(system: UFOSystem)
    {
        systems.append(system)
    }
    
    func addSystem(system: UFOSystem)
    {
        system.entityManager = self
        self.addSystemToNotificationsList(system)
        
        if system.updatePhase != .None
        {
            if var phase = systemsByPhase[system.updatePhase]
            {
                phase.append(system)
                systemsByPhase[system.updatePhase] = phase
            }
            else
            {
                systemsByPhase[system.updatePhase] = [system]
            }
        }
    }
    
    public func removeSystem(system: UFOSystem)
    {
        for i in 0 ..< systems.count
        {
            if systems[i] === system
            {
                systems.removeAtIndex(i)
                break
            }
        }
        
        for i in 0 ..< systemsByPhase[system.updatePhase]!.count
        {
            var phase: [UFOSystem] = systemsByPhase[system.updatePhase]!
            
            if phase[i] === system
            {
                phase.removeAtIndex(i)
                systemsByPhase[system.updatePhase] = phase
                break
            }
        }
    }
    
    // MARK: Private Methods
    
    private final func updateSystemsByPhase(phase: UFOUpdatePhase)
    {
        if let systemsToUpdate = systemsByPhase[phase]
        {
            for system in systemsToUpdate
            {
                system.update()
            }
        }
    }
    
    private final func initializeSystems()
    {
        for system in systems
        {
            system.initialize()
        }
    }
}

extension UFOEntityManager: UFOUpdatable
{
    public final func update()
    {
        if !paused
        {
            if !initialized
            {
                initializeSystems()
                initialized = true
            }
            
            updateSystemsByPhase(.Input)
            updateSystemsByPhase(.Physics)
            updateSystemsByPhase(.Main)
            updateSystemsByPhase(.PreRender)
            updateSystemsByPhase(.Render)
            
            //time++
        }
    }
}
