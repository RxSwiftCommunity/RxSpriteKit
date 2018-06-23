//
//  SKPhysicsWorld+Rx.swift
//  RxSpriteKit
//
//  Created by Maxim Volgin on 23/06/2018.
//  Copyright © 2018 Maxim Volgin. All rights reserved.
//

import SpriteKit
import RxSwift
import RxCocoa

extension Reactive where Base: SKPhysicsWorld {
    /// Reactive wrapper for `delegate`.
    /// For more information take a look at `DelegateProxyType` protocol documentation.
    public var delegate: DelegateProxy<SKPhysicsWorld, SKPhysicsContactDelegate> {
        return RxSKPhysicsContactDelegateProxy.proxy(for: base)
    }
    
    /// Installs delegate as forwarding delegate on `delegate`.
    /// Delegate won't be retained.
    ///
    /// It enables using normal delegate mechanism with reactive delegate mechanism.
    ///
    /// - parameter delegate: Delegate object.
    /// - returns: Disposable object that can be used to unbind the delegate.
    public func setDelegate(_ delegate: SKPhysicsContactDelegate)
        -> Disposable {
            return RxSKPhysicsContactDelegateProxy.installForwardDelegate(delegate, retainDelegate: false, onProxyForObject: self.base)
    }
    
    // MARK: - SKPhysicsContactDelegate
    
    // Reactive wrapper for delegate method `didBegin(_ contact: SKPhysicsContact)`
    public var didBeginContact: ControlEvent<SKPhysicsContact> {
        let source = delegate
            .methodInvoked(#selector(SKPhysicsContactDelegate.didBegin(_:)))
            .map { value -> SKPhysicsContact in
                return try castOrThrow(SKPhysicsContact.self, value[0] as AnyObject)
        }
        return ControlEvent(events: source)
    }

    // Reactive wrapper for delegate method `didEnd(_ contact: SKPhysicsContact)`
    public var didUEndContact: ControlEvent<SKPhysicsContact> {
        let source = delegate
            .methodInvoked(#selector(SKPhysicsContactDelegate.didEnd(_:)))
            .map { value -> SKPhysicsContact in
                return try castOrThrow(SKPhysicsContact.self, value[0] as AnyObject)
        }
        return ControlEvent(events: source)
    }
    
}
