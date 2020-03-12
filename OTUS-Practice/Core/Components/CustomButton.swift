//
//  CustomButton.swift
//  OTUS-Practice
//
//  Created by Mak on 12.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct CustomButton<Content>: View where Content: View {
    
    private let action: ()->Void
    private let content: ()->Content
    
    init(action: @escaping ()->Void, @ViewBuilder content: @escaping () -> Content) {
        self.action = action
        self.content = content
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .foregroundColor(.green)
            HStack {
                self.content()
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 14)
        }
        .fixedSize(horizontal: true, vertical: true)
        .simultaneousGesture(TapGesture().onEnded({
            self.action()
        }))
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(action: {}) {
            VStack {
                EmptyView()
                Text("Test")
            }
        }
    }
}
