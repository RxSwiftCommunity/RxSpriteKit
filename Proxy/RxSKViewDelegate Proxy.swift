//
//  RxSKViewDelegate Proxy.swift
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

public typealias RxSKViewDelegate = DelegateProxy<SKView, SKViewDelegate>

extension SKView: HasDelegate {
    public typealias Delegate = SKViewDelegate
}

open class RxSKViewDelegateProxy: RxSKViewDelegate, DelegateProxyType, SKViewDelegate {
    
    /// Type of parent object
    public weak private(set) var view: SKView?
    
    /// Init with parentObject
    public init(parentObject: ParentObject) {
        view = parentObject
        super.init(parentObject: parentObject, delegateProxy: RxSKViewDelegateProxy.self)
    }
    
    /// Register self to known implementations
    public static func registerKnownImplementations() {
        self.register { parent -> RxSKViewDelegateProxy in
            RxSKViewDelegateProxy(parentObject: parent)
        }
    }
    
    /// Gets the current `SKViewDelegate` on `SKView`
    open class func currentDelegate(for object: ParentObject) -> SKViewDelegate? {
        return object.delegate
    }
    
    /// Set the `SKViewDelegate` for `SKView`
    open class func setCurrentDelegate(_ delegate: SKViewDelegate?, to object: ParentObject) {
        object.delegate = delegate
    }
    
    // MARK: - lambda
    
    open var shouldRenderAtTime: ShouldRenderAtTime = RxSKViewDelegateProxy.defaultShouldRenderAtTime
    
    // MARK: - default lambda
    
    static let defaultShouldRenderAtTime: ShouldRenderAtTime = { (view, time) -> Bool in true }
    
    // MARK: - SKViewDelegate
    
    public func view(_ view: SKView, shouldRenderAtTime time: TimeInterval) -> Bool {
        return self.shouldRenderAtTime(view, time)
    }
    
}
