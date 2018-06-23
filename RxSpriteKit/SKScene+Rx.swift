//
//  SKScene+Rx.swift
//  RxSpriteKit
//
//  Created by Maxim Volgin on 23/06/2018.
//  Copyright © 2018 Maxim Volgin. All rights reserved.
//

import SpriteKit
import RxSwift
import RxCocoa

extension Reactive where Base: SKScene {
    /// Reactive wrapper for `delegate`.
    /// For more information take a look at `DelegateProxyType` protocol documentation.
    public var delegate: DelegateProxy<SKScene, SKSceneDelegate> {
        return RxSKSceneDelegateProxy.proxy(for: base)
    }
    
    /// Installs delegate as forwarding delegate on `delegate`.
    /// Delegate won't be retained.
    ///
    /// It enables using normal delegate mechanism with reactive delegate mechanism.
    ///
    /// - parameter delegate: Delegate object.
    /// - returns: Disposable object that can be used to unbind the delegate.
    public func setDelegate(_ delegate: SKSceneDelegate)
        -> Disposable {
            return RxSKSceneDelegateProxy.installForwardDelegate(delegate, retainDelegate: false, onProxyForObject: self.base)
    }
    
    // MARK:- SKSceneDelegate
    
//    optional public func update(_ currentTime: TimeInterval, for scene: SKScene)
//    optional public func didEvaluateActions(for scene: SKScene)
//    optional public func didSimulatePhysics(for scene: SKScene)
//    optional public func didApplyConstraints(for scene: SKScene)
//    optional public func didFinishUpdate(for scene: SKScene)
    
    // Reactive wrapper for delegate method `update(_ currentTime: TimeInterval, for scene: SKScene)`
    public var updateCurrentTime: ControlEvent<TimeInterval> {
        let source = delegate
            .methodInvoked(#selector(SKSceneDelegate.update(_:for:)))
            .map { value -> TimeInterval in
                return try castOrThrow(TimeInterval.self, value[0] as AnyObject)
        }
        return ControlEvent(events: source)
    }

    
    
    
}
