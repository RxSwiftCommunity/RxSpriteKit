//
//  SKPhysicsWorld+Rx.swift
//  RxSpriteKit
//
//  Created by Daniel Tartaglia on 21 Jan 2019.
//  Copyright © 2019 Daniel Tartaglia. MIT License.
//

import SpriteKit
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

public extension Reactive where Base: SKPhysicsWorld {
    
    public var didBeginContact: Observable<SKPhysicsContact> {
        
        return Observable.create { observer in
            
            RxPhysicsContactDelegateProxy.physicsContactDelegatesLock.lock(); defer { RxPhysicsContactDelegateProxy.physicsContactDelegatesLock.unlock() }
            let uuid = UUID()
            
            if var (delegate, beginners, enders) = RxPhysicsContactDelegateProxy.physicsContactDelegates[self.base] {
                beginners[uuid] = observer
                RxPhysicsContactDelegateProxy.physicsContactDelegates[self.base] = (delegate, beginners, enders)
            }
            else {
                let delegate = RxPhysicsContactDelegateProxy(for: self.base)
                self.base.contactDelegate = delegate
                RxPhysicsContactDelegateProxy.physicsContactDelegates[self.base] = (delegate, [uuid: observer], [:])
            }
            
            return Disposables.create {
                
                RxPhysicsContactDelegateProxy.physicsContactDelegatesLock.lock(); defer { RxPhysicsContactDelegateProxy.physicsContactDelegatesLock.unlock() }
                var (delegate, beginners, enders) = RxPhysicsContactDelegateProxy.physicsContactDelegates[self.base]!
                beginners.removeValue(forKey: uuid)
                
                if beginners.isEmpty && enders.isEmpty {
                    RxPhysicsContactDelegateProxy.physicsContactDelegates.removeValue(forKey: self.base)
                }
                else {
                    RxPhysicsContactDelegateProxy.physicsContactDelegates[self.base] = (delegate, beginners, enders)
                }
                
            }
            
        }
        
    }
    
    public var didEndContact: Observable<SKPhysicsContact> {
        
        return Observable.create { observer in
            
            RxPhysicsContactDelegateProxy.physicsContactDelegatesLock.lock(); defer { RxPhysicsContactDelegateProxy.physicsContactDelegatesLock.unlock() }
            let uuid = UUID()
            
            if var (delegate, beginners, enders) = RxPhysicsContactDelegateProxy.physicsContactDelegates[self.base] {
                enders[uuid] = observer
                RxPhysicsContactDelegateProxy.physicsContactDelegates[self.base] = (delegate, beginners, enders)
            }
            else {
                let delegate = RxPhysicsContactDelegateProxy(for: self.base)
                self.base.contactDelegate = delegate
                RxPhysicsContactDelegateProxy.physicsContactDelegates[self.base] = (delegate, [:], [uuid: observer])
            }
            
            return Disposables.create {
                
                RxPhysicsContactDelegateProxy.physicsContactDelegatesLock.lock(); defer { RxPhysicsContactDelegateProxy.physicsContactDelegatesLock.unlock() }
                var (delegate, beginners, enders) = RxPhysicsContactDelegateProxy.physicsContactDelegates[self.base]!
                enders.removeValue(forKey: uuid)
                
                if beginners.isEmpty && enders.isEmpty {
                    RxPhysicsContactDelegateProxy.physicsContactDelegates.removeValue(forKey: self.base)
                }
                else {
                    RxPhysicsContactDelegateProxy.physicsContactDelegates[self.base] = (delegate, beginners, enders)
                }
                
            }
            
        }
        
    }
    
}
