//
//  CustomButton.swift
//  OTUS-Practice
//
//  Created by Mak on 12.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct CustomButton: View {
    
    @Binding var selected: String
    
    let name: String
    
    var contentColorOn: Color = .init(dRed: 16, green: 130, blue: 23)
    var colorOn: Color = .init(dRed: 100, green: 228, blue: 108)
    var contentColorOff: Color = .init(dRed: 53, green: 53, blue: 53)
    var colorOff: Color = .init(dRed: 184, green: 184, blue: 184)
    
    var body: some View {
        let flag: Bool = selected.lowercased() == name.lowercased()
        
        return ZStack {
            Text(name)
                .foregroundColor(flag ? contentColorOn : contentColorOff)
                .font(.body)
                .padding(.all, 5)
        }
            .background(flag ? colorOn : colorOff)
            .cornerRadius(12)
            .simultaneousGesture(TapGesture().onEnded {
                self.selected = self.name.lowercased()
            })
    }
}
