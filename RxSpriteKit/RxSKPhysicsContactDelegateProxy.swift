//
//  RxSKPhysicsContactDelegateProxy.swift
//  RxSpriteKit
//
//  Created by Maxim Volgin on 23/06/2018.
//  Copyright © 2018 Maxim Volgin. All rights reserved.
//

import SpriteKit
import RxSwift
import RxCocoa

extension SKPhysicsWorld: HasDelegate {
    public var delegate: SKPhysicsContactDelegate? {
        get {
            return self.contactDelegate
        }
        set(newValue) {
            self.contactDelegate = newValue
        }
    }
    public typealias Delegate = SKPhysicsContactDelegate
}

open class RxSKPhysicsContactDelegateProxy:
    DelegateProxy<SKPhysicsWorld, SKPhysicsContactDelegate>,
    DelegateProxyType,
    SKPhysicsContactDelegate {
    
    /// Typed parent object.
    public weak private(set) var world: SKPhysicsWorld?
    
    /// - parameter view: Parent object for delegate proxy.
    public init(world: ParentObject) {
        self.world = world
        super.init(parentObject: world, delegateProxy: RxSKPhysicsContactDelegateProxy.self)
    }
    
    // Register known implementationss
    public static func registerKnownImplementations() {
        self.register { RxSKPhysicsContactDelegateProxy(world: $0) }
    }
}
