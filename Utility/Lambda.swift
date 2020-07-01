//
//  Lambda.swift
//  RxSpriteKit
//
//  Created by Maxim Volgin on 27/10/2018.
//  Copyright (c) RxSwiftCommunity. All rights reserved.
//

import SpriteKit

// MARK: - SKViewDelegate

@available(iOS 10.0, *)
public typealias ShouldRenderAtTime = (SKView, TimeInterval) -> Bool
