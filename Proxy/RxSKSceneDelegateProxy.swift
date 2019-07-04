//
//  RxSKSceneDelegateProxy.swift
//  RxSpriteKit
//
//  Created by Maxim Volgin on 23/06/2018.
//  Copyright (c) RxSwiftCommunity. All rights reserved.
//

import SpriteKit
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

public typealias RxSKSceneDelegate = DelegateProxy<SKScene, SKSceneDelegate>

extension SKScene: HasDelegate {
    public typealias Delegate = SKSceneDelegate
}

open class RxSKSceneDelegateProxy: RxSKSceneDelegate, DelegateProxyType, SKSceneDelegate {
    
    /// Type of parent object
    public weak private(set) var scene: SKScene?
    
    /// Init with parentObject
    public init(parentObject: ParentObject) {
        scene = parentObject
        super.init(parentObject: parentObject, delegateProxy: RxSKSceneDelegateProxy.self)
    }
    
    /// Register self to known implementations
    public static func registerKnownImplementations() {
        self.register { parent -> RxSKSceneDelegateProxy in
            RxSKSceneDelegateProxy(parentObject: parent)
        }
    }
    
    /// Gets the current `SKSceneDelegate` on `SKScene`
    open class func currentDelegate(for object: ParentObject) -> SKSceneDelegate? {
        return object.delegate
    }
    
    /// Set the `SKSceneDelegate` for `SKScene`
    open class func setCurrentDelegate(_ delegate: SKSceneDelegate?, to object: ParentObject) {
        object.delegate = delegate
    }
    
}
