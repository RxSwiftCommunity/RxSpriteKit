//
//  RxSKPhysicsContactDelegateProxy.swift
//  RxSpriteKit
//
//  Created by Maxim Volgin on 23/06/2018.
//  Copyright © 2018 Maxim Volgin. All rights reserved.
//

import SpriteKit
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

public typealias RxSKPhysicsContactDelegate = DelegateProxy<SKPhysicsWorld, SKPhysicsContactDelegate>

extension SKPhysicsWorld: HasDelegate {
    public typealias Delegate = SKPhysicsContactDelegate
    
    public var delegate: Delegate? {
        get {
            return self.contactDelegate
        }
        set {
            self.contactDelegate = newValue
        }
    }
}

open class RxSKPhysicsContactDelegateProxy: RxSKPhysicsContactDelegate, DelegateProxyType, SKPhysicsContactDelegate {
    
    /// Type of parent object
    public weak private(set) var physicsWorld: SKPhysicsWorld?
    
    /// Init with parentObject
    public init(parentObject: ParentObject) {
        physicsWorld = parentObject
        super.init(parentObject: parentObject, delegateProxy: RxSKPhysicsContactDelegateProxy.self)
    }
    
    /// Register self to known implementations
    public static func registerKnownImplementations() {
        self.register { parent -> RxSKPhysicsContactDelegateProxy in
            RxSKPhysicsContactDelegateProxy(parentObject: parent)
        }
    }
    
    /// Gets the current `SKPhysicsContactDelegate` on `SKPhysicsWorld`
    open class func currentDelegate(for object: ParentObject) -> SKPhysicsContactDelegate? {
        return object.delegate
    }
    
    /// Set the `SKPhysicsContactDelegate` for `SKPhysicsWorld`
    open class func setCurrentDelegate(_ delegate: SKPhysicsContactDelegate?, to object: ParentObject) {
        object.delegate = delegate
    }
    
}

