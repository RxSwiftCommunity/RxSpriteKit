//
//  SKScene+Rx.swift
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

extension Reactive where Base: SKScene {
    
    // MARK: - SKSceneDelegate
    
    public var update: ControlEvent<EventUpdate> {
        let source: Observable<EventUpdate> = delegate
            .methodInvoked(.update)
            .map(toEventUpdate)
        return ControlEvent(events: source)
    }
    
    public var didEvaluateActions: ControlEvent<SKScene> {
        let source: Observable<SKScene> = delegate
            .methodInvoked(.didEvaluateActions)
            .map(toSKScene)
        return ControlEvent(events: source)
    }
    
    public var didSimulatePhysics: ControlEvent<SKScene> {
        let source: Observable<SKScene> = delegate
            .methodInvoked(.didSimulatePhysics)
            .map(toSKScene)
        return ControlEvent(events: source)
    }
    
    public var didApplyConstraints: ControlEvent<SKScene> {
        let source: Observable<SKScene> = delegate
            .methodInvoked(.didApplyConstraints)
            .map(toSKScene)
        return ControlEvent(events: source)
    }
    
    public var didFinishUpdate: ControlEvent<SKScene> {
        let source: Observable<SKScene> = delegate
            .methodInvoked(.didFinishUpdate)
            .map(toSKScene)
        return ControlEvent(events: source)
    }
    
    // MARK: -
    
    /// Reactive wrapper for `delegate`.
    /// For more information take a look at `DelegateProxyType` protocol documentation.
    public var delegate: DelegateProxy<SKScene, SKSceneDelegate> {
        return RxSKSceneDelegateProxy.proxy(for: base)
    }
    
    /// Installs delegate as forwarding delegate on `delegate`.
    /// Delegate won't be retained.
    ///
    /// It enables using normal delegKate mechanism with reactive delegate mechanism.
    ///
    /// - parameter delegate: Delegate object.
    /// - returns: Disposable object that can be used to unbind the delegate.
    public func setDelegate(_ delegate: SKSceneDelegate)
        -> Disposable {
            return RxSKSceneDelegateProxy.installForwardDelegate(delegate, retainDelegate: false, onProxyForObject: self.base)
    }
    
}
