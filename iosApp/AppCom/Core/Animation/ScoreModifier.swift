//
//  ScoreModifier.swift
//  OTUS-Practice
//
//  Created by Максим Сытый on 07.07.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct ScoreModifier: AnimatableModifier {
    
    var animatableData: CGFloat
    
    func body(content: Content) -> some View {
        content
            .overlay(LabelView(score: animatableData))
            .modifier(Shake(animatableData: animatableData))
    }
    
    struct LabelView: View {
        let score: CGFloat
        var body: some View {
            Text("\(score, specifier: "%0.2f") %")
                .frame(width: 300)
                .font(.headline)
        }
    }
}
