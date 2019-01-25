# RxSpriteKit
RxSpriteKit (based on RxSwift)

See demo project RxSpriteGame (https://github.com/maxvol/RxSpriteGame) for reference.

Basic usage.

```swift

skView.
    .rx
    .shouldRenderAtTime
    .subscribe { event in
        switch event {
            case .next(let shouldRenderAtTime):
            // TODO: ...
        break
            default:
        break
        }
    }
    .disposed(by: disposeBag)
    
skScene
    .rx
    .update
    .subscribe { event in
    switch event {
        case .next(let update):
            // TODO: ...
            break
        default:
            break
        }
    }
    .disposed(by: disposeBag)
    
    
physicsWorld
    .rx
    .didBeginContact
    .subscribe { event in
    switch event {
        case .next(let didBeginContact):
            // TODO: ...
            break
        default:
            break
        }
    }
    .disposed(by: disposeBag)
    
    
```

Carthage setup.

```
github "maxvol/RxSpriteKit" ~> 0.0.3

```

