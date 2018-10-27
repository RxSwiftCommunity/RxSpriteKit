# RxSpriteKit
RxSpriteKit (based on RxSwift)

Basic usage.

```swift

skView.
    .rx
    .didUpdateNodeForAnchor
    .subscribe { event in
        switch event {
            case .next(let didUpdateNodeForAnchor):
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
github "maxvol/RxSpriteKit" ~> 0.0.2

```

