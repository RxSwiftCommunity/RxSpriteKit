//
//  SKPhysicsWorld+Rx.swift
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

extension Reactive where Base: SKPhysicsWorld {

    // MARK: - SKPhysicsContactDelegate
    
    public var didBeginContact: ControlEvent<SKPhysicsContact> {
        let source: Observable<SKPhysicsContact> = delegate
            .methodInvoked(.didBeginContact)
            .map(toSKPhysicsContact)
        return ControlEvent(events: source)
    }
    
    public var didEndContact: ControlEvent<SKPhysicsContact> {
        let source: Observable<SKPhysicsContact> = delegate
            .methodInvoked(.didEndContact)
            .map(toSKPhysicsContact)
        return ControlEvent(events: source)
    }
    
    // MARK: -
    
    /// Reactive wrapper for `delegate`.
    /// For more information take a look at `DelegateProxyType` protocol documentation.
    public var delegate: DelegateProxy<SKPhysicsWorld, SKPhysicsContactDelegate> {
        return RxSKPhysicsContactDelegateProxy.proxy(for: base)
    }
    
    /// Installs delegate as forwarding delegate on `delegate`.
    /// Delegate won't be retained.
    ///
    /// It enables using normal delegKate mechanism with reactive delegate mechanism.
    ///
    /// - parameter delegate: Delegate object.
    /// - returns: Disposable object that can be used to unbind the delegate.
    public func setDelegate(_ delegate: SKPhysicsContactDelegate)
        -> Disposable {
            return RxSKPhysicsContactDelegateProxy.installForwardDelegate(delegate, retainDelegate: false, onProxyForObject: self.base)
    }
    
}
