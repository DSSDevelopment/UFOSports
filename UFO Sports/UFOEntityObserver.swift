//
//  UFOEntityObserver.swift
//  UFO Sports
//
//  Created by Derek Sanchez on 11/13/14.
//  Copyright (c) 2014 Dramatech. All rights reserved.
//

protocol UFOEntityObserver
{
    func added(entity: UFOEntity)
    func removed(entity: UFOEntity)
    func changed(entity: UFOEntity)
}
