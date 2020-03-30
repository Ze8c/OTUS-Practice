//
//  TapAnimatig.swift
//  OTUS-Practice
//
//  Created by Mak on 30.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct TapAnimatig: View {
    
    @State var score: CGFloat = 0
    
    @State var heartScale = false
    @State var heartAlpha = false
    
    @State var airplaneScale = false
    @State var airplaneColor = false
    
    var body: some View {
        VStack {
            Spacer()
            Color.green.hueRotation(Angle(radians: Double(score)))
                .clipShape(Circle())
                .frame(height: 200)
                .modifier(ScoreModifier(animatableData: score))
            Button(action: {
                self.score += 5
            }) {
                Image(systemName: "plus.circle.fill")
                    .scaleEffect(3)
            }
            Divider()
            Spacer()
            Image(systemName: "suit.heart.fill")
                .foregroundColor(.red)
                .scaleEffect(heartScale ? 1.0 : 3.0)
                .opacity(heartAlpha ? 0.1 : 1.0)
                .animation(.easeInOut(duration: 1.0))
                .onTapGesture {
                    self.heartScale.toggle()
                    self.heartAlpha.toggle()
            }
            Spacer()
            Image(systemName: "airplane")
                .foregroundColor(airplaneColor ? .blue : .yellow)
                .scaleEffect(airplaneScale ? 1.0 : 3.0)
                .animation(.easeInOut(duration: 1.0))
                .onTapGesture {
                    self.airplaneScale.toggle()
                    // Explicit
                    withAnimation(.easeInOut(duration: 1.0)) {
                        self.airplaneColor.toggle()
                    }
                    
            }
            Spacer()
        }
        .animation(Animation.easeInOut.speed(0.5))
    }
}


struct Shake: GeometryEffect {
    var animatableData: CGFloat
    func effectValue(size: CGSize) -> ProjectionTransform {
        .init(CGAffineTransform(translationX: -30*sin(animatableData * .pi), y: 0))
    }
}

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

struct TapAnimatig_Previews: PreviewProvider {
    static var previews: some View {
        TapAnimatig()
    }
}
