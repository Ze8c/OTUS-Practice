//
//  StretchyHeader.swift
//  OTUS-Practice
//
//  Created by Mak on 26.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct HeightModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: 400)
    }
}

struct StretchyHeader<H: View, C: View>: View {
    
    private var header: H
    private var content: C
    
    init(@ViewBuilder header: () -> H, @ViewBuilder content: () -> C) {
        self.header = header()
        self.content = content()
    }
    
    var body: some View {
        VStack {
            ScrollView {
                GeometryReader { g in
                    self.getView(g)
                } // Geometry
                .modifier(HeightModifier())
                
                content
            }
            Spacer()
        } // VStack
    }
    
    private func getView(_ g: GeometryProxy) -> some View {
        let frameH: CGFloat
        let offsetY: CGFloat
        if g.frame(in: .global).minY <= 0 {
            frameH = g.size.height
            offsetY = g.frame(in: .global).minY/9
        } else {
            frameH = g.size.height + g.frame(in: .global).minY
            offsetY = -g.frame(in: .global).minY
        }
        
        return self.header
            .frame(width: g.size.width,
                   height: frameH)
            .offset(y: offsetY)
    }
}
