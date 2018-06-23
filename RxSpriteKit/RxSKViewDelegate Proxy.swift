//
//  RxSKViewDelegate Proxy.swift
//  RxSpriteKit
//
//  Created by Maxim Volgin on 23/06/2018.
//  Copyright © 2018 Maxim Volgin. All rights reserved.
//

import SpriteKit
import RxSwift
import RxCocoa

extension SKView: HasDelegate {
    public typealias Delegate = SKViewDelegate
}

open class RxSKViewDelegateProxy:
    DelegateProxy<SKView, SKViewDelegate>,
    DelegateProxyType,
    SKViewDelegate {
    
    /// Typed parent object.
    public weak private(set) var view: SKView?
    
    /// - parameter view: Parent object for delegate proxy.
    public init(view: ParentObject) {
        self.view = view
        super.init(parentObject: view, delegateProxy: RxSKViewDelegateProxy.self)
    }
    
    // Register known implementationss
    public static func registerKnownImplementations() {
        self.register { RxSKViewDelegateProxy(view: $0) }
    }
}
