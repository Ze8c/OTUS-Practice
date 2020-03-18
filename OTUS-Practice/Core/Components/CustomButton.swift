//
//  CustomButton.swift
//  OTUS-Practice
//
//  Created by Mak on 12.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct CustomButton<Content>: View where Content: View {
    
    @Binding var isOn: Bool
    let name: String
    
    var contentColorOn: Color = .init(dRed: 16, green: 130, blue: 23)
    var colorOn: Color = .init(dRed: 100, green: 228, blue: 108)
    var contentColorOff: Color = .init(dRed: 53, green: 53, blue: 53)
    var colorOff: Color = .init(dRed: 184, green: 184, blue: 184)
    
    let action: (String) -> Void
    let content: (String) -> Content
    
    var body: some View {
        ZStack {
            self.content(self.name)
                .font(.body)
                .foregroundColor(isOn ? contentColorOn : contentColorOff)
                .padding(.all, 5)
        }
            .foregroundColor(.green)
            .cornerRadius(12)
            .background(isOn ? colorOn : colorOff)
            .simultaneousGesture(TapGesture().onEnded({
                self.isOn.toggle()
                self.action(self.name.lowercased())
            }))
    }
}
