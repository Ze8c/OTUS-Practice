//
//  Shake.swift
//  OTUS-Practice
//
//  Created by Максим Сытый on 07.07.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct Shake: GeometryEffect {
    var animatableData: CGFloat
    func effectValue(size: CGSize) -> ProjectionTransform {
        .init(CGAffineTransform(translationX: -30*sin(animatableData * .pi), y: 0))
    }
}
