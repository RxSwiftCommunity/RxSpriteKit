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

public
extension Reactive where Base: SKPhysicsWorld {

    public
    var didBegin: Observable<SKPhysicsContact> {
        return Observable.create { observer in
            physicsContatctDelegatesLock.lock(); defer { physicsContatctDelegatesLock.unlock() }
            let uuid = UUID()
            if var (delegate, beginners, enders) = physicsContatctDelegates[self.base] {
                beginners[uuid] = observer
                physicsContatctDelegates[self.base] = (delegate, beginners, enders)
            }
            else {
                let delegate = PhysicsContactDelegate(for: self.base)
                self.base.contactDelegate = delegate
                physicsContatctDelegates[self.base] = (delegate, [uuid: observer], [:])
            }

            return Disposables.create {
                physicsContatctDelegatesLock.lock(); defer { physicsContatctDelegatesLock.unlock() }
                var (delegate, beginners, enders) = physicsContatctDelegates[self.base]!
                beginners.removeValue(forKey: uuid)
                if beginners.isEmpty && enders.isEmpty {
                    physicsContatctDelegates.removeValue(forKey: self.base)
                }
                else {
                    physicsContatctDelegates[self.base] = (delegate, beginners, enders)
                }
            }
        }
    }

    public
    var didEnd: Observable<SKPhysicsContact> {
        return Observable.create { observer in
            physicsContatctDelegatesLock.lock(); defer { physicsContatctDelegatesLock.unlock() }
            let uuid = UUID()
            if var (delegate, beginners, enders) = physicsContatctDelegates[self.base] {
                enders[uuid] = observer
                physicsContatctDelegates[self.base] = (delegate, beginners, enders)
            }
            else {
                let delegate = PhysicsContactDelegate(for: self.base)
                self.base.contactDelegate = delegate
                physicsContatctDelegates[self.base] = (delegate, [:], [uuid: observer])
            }

            return Disposables.create {
                physicsContatctDelegatesLock.lock(); defer { physicsContatctDelegatesLock.unlock() }
                var (delegate, beginners, enders) = physicsContatctDelegates[self.base]!
                enders.removeValue(forKey: uuid)
                if beginners.isEmpty && enders.isEmpty {
                    physicsContatctDelegates.removeValue(forKey: self.base)
                }
                else {
                    physicsContatctDelegates[self.base] = (delegate, beginners, enders)
                }
            }
        }
    }
}

private
class PhysicsContactDelegate: NSObject, SKPhysicsContactDelegate {

    init(for world: SKPhysicsWorld) {
        self.world = world
        super.init()
    }

    func didBegin(_ contact: SKPhysicsContact) {
        physicsContatctDelegatesLock.lock(); defer { physicsContatctDelegatesLock.unlock() }
        let (_, beginners, _) = physicsContatctDelegates[world]!
        for each in beginners.values {
            each.onNext(contact)
        }
    }

    func didEnd(_ contact: SKPhysicsContact) {
        physicsContatctDelegatesLock.lock(); defer { physicsContatctDelegatesLock.unlock() }
        let (_, _, enders) = physicsContatctDelegates[world]!
        for each in enders.values {
            each.onNext(contact)
        }
    }

    let world: SKPhysicsWorld
}

private let physicsContatctDelegatesLock = NSRecursiveLock()
private var physicsContatctDelegates: [SKPhysicsWorld: (SKPhysicsContactDelegate, [UUID: AnyObserver<SKPhysicsContact>], [UUID: AnyObserver<SKPhysicsContact>])] = [:]
