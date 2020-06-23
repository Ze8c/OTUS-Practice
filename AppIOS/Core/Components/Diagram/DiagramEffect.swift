//
//  DiagramEffect.swift
//  OTUS-Practice
//
//  Created by Mak on 30.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct DiagramEffect: GeometryEffect {
    
    var callback: (CGFloat) -> ()
    var animatableData: CGFloat
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        callback(animatableData)
        return ProjectionTransform()
    }
    
}
