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
    
    // Reactive wrapper for delegate method `session(_ session: ARSession, didUpdate frame: ARFrame)`
//    public var didUpdateFrame: ControlEvent<ARFrame> {
//        let source = delegate
//            .methodInvoked(#selector(ARSessionDelegate.session(_:didUpdate:) as ((ARSessionDelegate) -> (ARSession, ARFrame) -> Void)?))
//            .map { value -> ARFrame in
//                return try castOrThrow(ARFrame.self, value[1] as AnyObject)
//        }
//        return ControlEvent(events: source)
//    }
//
    
    
    
}
