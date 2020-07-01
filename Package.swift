// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "RxSpriteKit",
    platforms: [
        .macOS(.v10_10), .iOS(.v8), .tvOS(.v9), .watchOS(.v3)
    ],
    products: [
        .library(
            name: "RxSpriteKit",
            targets: ["RxSpriteKit", "iOS_RxSpriteKit", "macOS_RxSpriteKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "5.1.1")
    ],
    targets: [
        .target(
            name: "RxSpriteKit",
            dependencies: ["RxSwift", "RxRelay", "RxCocoa"],
            path: "."),
//        .testTarget(
//            name: "RxSpriteKitTests",
//            dependencies: ["RxSpriteKit"],
//            path: "Tests"
//        )
    ]
)
