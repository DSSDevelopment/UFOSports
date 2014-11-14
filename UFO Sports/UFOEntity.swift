//
//  Entity.swift
//  UFO Sports
//
//  Created by Derek Sanchez on 11/13/14.
//  Copyright (c) 2014 Dramatech. All rights reserved.
//

import Foundation

public final class UFOEntity
{
    var eid: Int64                              = 0
    var components: [String: UFOComponent]      = [:]
    var hasChanged: Bool                        = false
    
    func initWithEid(eid: Int64) -> UFOEntity
    {
        self.eid = eid
        return self
    }
    
    public func get<T: UFOComponent>(type: T.Type) -> T?
    {
        return components[type.type()] as? T
    }
    
    public func getByTypeName(typeName: String) -> UFOComponent?
    {
        return components[typeName]
    }
    
    public func has(type: String) -> Bool
    {
        return components[type] != nil
    }
    
    public func has<T: UFOComponent>(type: T.Type) -> Bool
    {
        return has(type.type())
    }
    
    public func put(#component: UFOComponent)
    {
        components[component.type()] = component
    }
    
    public func put(componentsToPut: [UFOComponent])
    {
        for component in componentsToPut
        {
            put(component: component)
        }
    }
    
    public func put(componentsToPut: UFOComponent...)
    {
        put(componentsToPut)
    }
    
    public func remove<T: UFOComponent>(type: T.Type)
    {
        components[type.type()] = nil
    }
    
}

extension UFOEntity: Hashable
{
    public var hashValue: Int
        {
            return Int(eid)
    }
}

public func == (left: UFOEntity, right: UFOEntity) -> Bool
{
    return left.hashValue == right.hashValue
}


