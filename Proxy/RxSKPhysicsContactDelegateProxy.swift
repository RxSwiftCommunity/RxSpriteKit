//
//  RxSKPhysicsContactDelegateProxy.swift
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

class RxSKPhysicsContactDelegateProxy: NSObject, SKPhysicsContactDelegate {
    
    static var physicsContactDelegates: [SKPhysicsWorld: (SKPhysicsContactDelegate, [UUID: AnyObserver<SKPhysicsContact>], [UUID: AnyObserver<SKPhysicsContact>])] = [:]
    static let physicsContactDelegatesLock = NSRecursiveLock()

    let world: SKPhysicsWorld

    init(for world: SKPhysicsWorld) {
        self.world = world
        super.init()
    }

    func didBegin(_ contact: SKPhysicsContact) {
        
        RxSKPhysicsContactDelegateProxy.physicsContactDelegatesLock.lock(); defer { RxSKPhysicsContactDelegateProxy.physicsContactDelegatesLock.unlock() }
        let (_, beginners, _) = RxSKPhysicsContactDelegateProxy.physicsContactDelegates[world]!
        
        for each in beginners.values {
            each.onNext(contact)
        }
        
    }

    func didEnd(_ contact: SKPhysicsContact) {
        
        RxSKPhysicsContactDelegateProxy.physicsContactDelegatesLock.lock(); defer { RxSKPhysicsContactDelegateProxy.physicsContactDelegatesLock.unlock() }
        let (_, _, enders) = RxSKPhysicsContactDelegateProxy.physicsContactDelegates[world]!
        
        for each in enders.values {
            each.onNext(contact)
        }
        
    }

}
