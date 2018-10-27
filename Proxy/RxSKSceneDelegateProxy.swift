//
//  RxSKSceneDelegateProxy.swift
//  RxSpriteKit
//
//  Created by Maxim Volgin on 23/06/2018.
//  Copyright © 2018 Maxim Volgin. All rights reserved.
//

import SpriteKit
import RxSwift
import RxCocoa

extension SKScene: HasDelegate {
    public typealias Delegate = SKSceneDelegate
}

open class RxSKSceneDelegateProxy:
    DelegateProxy<SKScene, SKSceneDelegate>,
    DelegateProxyType,
    SKSceneDelegate {
    
    /// Typed parent object.
    public weak private(set) var scene: SKScene?
    
    /// - parameter view: Parent object for delegate proxy.
    public init(scene: ParentObject) {
        self.scene = scene
        super.init(parentObject: scene, delegateProxy: RxSKSceneDelegateProxy.self)
    }
    
    // Register known implementationss
    public static func registerKnownImplementations() {
        self.register { RxSKSceneDelegateProxy(scene: $0) }
    }
}
