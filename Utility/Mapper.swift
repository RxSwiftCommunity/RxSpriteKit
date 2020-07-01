//
//  Mapper.swift
//  RxSpriteKit
//
//  Created by Maxim Volgin on 27/10/2018.
//  Copyright (c) RxSwiftCommunity. All rights reserved.
//

import SpriteKit
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

// MARK: - SKViewDelegate

// MARK: - SKSceneDelegate

@available(iOS 10.0, *)
func toEventUpdate(_ args: [Any]) throws -> EventUpdate {
    let currentTime = try castOrThrow(TimeInterval.self, args[0])
    let scene = try castOrThrow(SKScene.self, args[1])
    return (currentTime, scene)
}

@available(iOS 10.0, *)
func toSKScene(_ args: [Any]) throws -> SKScene {
    let scene = try castOrThrow(SKScene.self, args[0])
    return scene
}

//MARK: - SKPhysicsContactDelegate

@available(iOS 10.0, *)
func toSKPhysicsContact(_ args: [Any]) throws -> SKPhysicsContact {
    let contact = try castOrThrow(SKPhysicsContact.self, args[0])
    return contact
}
