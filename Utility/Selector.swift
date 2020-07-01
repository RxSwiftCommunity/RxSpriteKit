//
//  Selector.swift
//  RxSpriteKit
//
//  Created by Maxim Volgin on 27/10/2018.
//  Copyright (c) RxSwiftCommunity. All rights reserved.
//

import SpriteKit

// MARK: - SKViewDelegate

// MARK: - SKSceneDelegate

@available(iOS 10.0, *)
extension Selector {
    static let update = #selector(SKSceneDelegate.update(_:for:))
    static let didEvaluateActions = #selector(SKSceneDelegate.didEvaluateActions(for:))
    static let didSimulatePhysics = #selector(SKSceneDelegate.didSimulatePhysics(for:))
    static let didApplyConstraints = #selector(SKSceneDelegate.didApplyConstraints(for:))
    static let didFinishUpdate = #selector(SKSceneDelegate.didFinishUpdate(for:))
}

//MARK: - SKPhysicsContactDelegate

@available(iOS 10.0, *)
extension Selector {
    static let didBeginContact = #selector(SKPhysicsContactDelegate.didBegin(_:))
    static let didEndContact = #selector(SKPhysicsContactDelegate.didEnd(_:))
}
