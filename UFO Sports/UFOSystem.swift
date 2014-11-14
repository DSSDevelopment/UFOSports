//
//  System.swift
//  UFO Sports
//
//  Created by Derek Sanchez on 11/13/14.
//  Copyright (c) 2014 Dramatech. All rights reserved.
//

public class UFOSystem
{
    public final var entities   = [UFOEntity]()
    public var updatePhase      = UFOUpdatePhase.Main
    public var entityManager    : UFOEntityManager!
    
    public init () {}
    
    convenience init(entityManager: UFOEntityManager)
    {
        self.init()
        entityManager.addSystemToNotificationsList(self)
    }
    
    public func accepts(entity: UFOEntity) -> Bool
    {
        return false
    }
    
    public func add(entity: UFOEntity)
    {
        if(accepts(entity)){ entities.append(entity) }
    }
    
    public func remove(entity: UFOEntity)
    {
        for i in 0 ..< entities.count
        {
            if entities[i] == entity
            {
                remove(i)
                break
            }
        }
    }
    
    public func remove(index: Int)
    {
        entities.removeAtIndex(index)
    }
    
    //This method will eventually need to actually check if the changed entity is valid for the system and
    //remove it if it is not.
    public func change(entity: UFOEntity)
    {
        for i in 0 ..< entities.count
        {
            if entities[i] == entity
            {
                change(i)
                break
            }
        }
    }
    
    public func change(index: Int) {}
    
    public func initialize() {}
    public func update() {}
}

extension UFOSystem: UFOEntityObserver
{
    func added(entity: UFOEntity)
    {
        if accepts(entity)
        {
            add(entity)
        }
    }
    
    func removed(entity: UFOEntity)
    {
        remove(entity)
    }
    
    func changed(entity: UFOEntity)
    {
        var contained = false
        
        for i in 0 ..< entities.count
        {
            if entities[i] === entity
            {
                contained = true
                
                if !accepts(entity)
                {
                    // No longer a valid entity in this system; remove it
                    remove(i)
                }
                else
                {
                    // Alert the system that this entity changed
                    change(entity)
                }
                
                break
            }
        }
        
        if !contained && accepts(entity)
        {
            // Now a valid entity in this system; add it
            add(entity)
        }
    }
}
