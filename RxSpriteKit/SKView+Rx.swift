//
//  SKView+Rx.swift
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

extension Reactive where Base: SKView {
    
    // MARK: - SKViewDelegate
    
    public var shouldRenderAtTime: ShouldRenderAtTime {
        get {
            return proxy?.shouldRenderAtTime ?? RxSKViewDelegateProxy.defaultShouldRenderAtTime
        }
        set {
            proxy?.shouldRenderAtTime = newValue
        }
    }
    
    // MARK: - private
    
    var proxy: RxSKViewDelegateProxy? {
        return self.delegate as? RxSKViewDelegateProxy
    }
    
    // MARK: -
    
    /// Reactive wrapper for `delegate`.
    /// For more information take a look at `DelegateProxyType` protocol documentation.
    public var delegate: DelegateProxy<SKView, SKViewDelegate> {
        return RxSKViewDelegateProxy.proxy(for: base)
    }
    
    /// Installs delegate as forwarding delegate on `delegate`.
    /// Delegate won't be retained.
    ///
    /// It enables using normal delegKate mechanism with reactive delegate mechanism.
    ///
    /// - parameter delegate: Delegate object.
    /// - returns: Disposable object that can be used to unbind the delegate.
    public func setDelegate(_ delegate: SKViewDelegate)
        -> Disposable {
            return RxSKViewDelegateProxy.installForwardDelegate(delegate, retainDelegate: false, onProxyForObject: self.base)
    }
    
}
