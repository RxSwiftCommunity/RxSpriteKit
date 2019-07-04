//
//  SKPhysicsWorld+Rx.swift
//  RxSpriteKit
//
//  Created by Daniel Tartaglia on 21 Jan 2019.
//  Copyright (c) RxSwiftCommunity. All rights reserved.
//

import SpriteKit
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

public extension Reactive where Base: SKPhysicsWorld {
    
    public var didBeginContact: Observable<SKPhysicsContact> {
        
        return Observable.create { observer in
            
            RxSKPhysicsContactDelegateProxy.physicsContactDelegatesLock.lock(); defer { RxSKPhysicsContactDelegateProxy.physicsContactDelegatesLock.unlock() }
            let uuid = UUID()
            
            if var (delegate, beginners, enders) = RxSKPhysicsContactDelegateProxy.physicsContactDelegates[self.base] {
                beginners[uuid] = observer
                RxSKPhysicsContactDelegateProxy.physicsContactDelegates[self.base] = (delegate, beginners, enders)
            }
            else {
                let delegate = RxSKPhysicsContactDelegateProxy(for: self.base)
                self.base.contactDelegate = delegate
                RxSKPhysicsContactDelegateProxy.physicsContactDelegates[self.base] = (delegate, [uuid: observer], [:])
            }
            
            return Disposables.create {
                
                RxSKPhysicsContactDelegateProxy.physicsContactDelegatesLock.lock(); defer { RxSKPhysicsContactDelegateProxy.physicsContactDelegatesLock.unlock() }
                var (delegate, beginners, enders) = RxSKPhysicsContactDelegateProxy.physicsContactDelegates[self.base]!
                beginners.removeValue(forKey: uuid)
                
                if beginners.isEmpty && enders.isEmpty {
                    RxSKPhysicsContactDelegateProxy.physicsContactDelegates.removeValue(forKey: self.base)
                }
                else {
                    RxSKPhysicsContactDelegateProxy.physicsContactDelegates[self.base] = (delegate, beginners, enders)
                }
                
            }
            
        }
        
    }
    
    public var didEndContact: Observable<SKPhysicsContact> {
        
        return Observable.create { observer in
            
            RxSKPhysicsContactDelegateProxy.physicsContactDelegatesLock.lock(); defer { RxSKPhysicsContactDelegateProxy.physicsContactDelegatesLock.unlock() }
            let uuid = UUID()
            
            if var (delegate, beginners, enders) = RxSKPhysicsContactDelegateProxy.physicsContactDelegates[self.base] {
                enders[uuid] = observer
                RxSKPhysicsContactDelegateProxy.physicsContactDelegates[self.base] = (delegate, beginners, enders)
            }
            else {
                let delegate = RxSKPhysicsContactDelegateProxy(for: self.base)
                self.base.contactDelegate = delegate
                RxSKPhysicsContactDelegateProxy.physicsContactDelegates[self.base] = (delegate, [:], [uuid: observer])
            }
            
            return Disposables.create {
                
                RxSKPhysicsContactDelegateProxy.physicsContactDelegatesLock.lock(); defer { RxSKPhysicsContactDelegateProxy.physicsContactDelegatesLock.unlock() }
                var (delegate, beginners, enders) = RxSKPhysicsContactDelegateProxy.physicsContactDelegates[self.base]!
                enders.removeValue(forKey: uuid)
                
                if beginners.isEmpty && enders.isEmpty {
                    RxSKPhysicsContactDelegateProxy.physicsContactDelegates.removeValue(forKey: self.base)
                }
                else {
                    RxSKPhysicsContactDelegateProxy.physicsContactDelegates[self.base] = (delegate, beginners, enders)
                }
                
            }
            
        }
        
    }
    
}
