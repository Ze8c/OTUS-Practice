//
//  AnyTransitionExt.swift
//  OTUS-Practice
//
//  Created by Mak on 12.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

extension AnyTransition {
    
    static var moveAndFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        let removal = AnyTransition.scale
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
}
