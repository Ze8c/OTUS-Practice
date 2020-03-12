//
//  DetailInfo.swift
//  OTUS-Practice
//
//  Created by Mak on 04.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct DetailInfo: View {
    
    @State var isOn: Bool = false
    
    var element: Contact
    
    var body: some View {
        Group {
            VStack {
                HStack {
                    Spacer()
                
                    Image(systemName: element.imgName)
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                        .foregroundColor(element.imgColor)
                
                    Spacer()
                
                    VStack {
                        Text(element.name)
                            .font(.title)
                    
                        Text(element.id)
                            .font(.body)
                    } //VStack
                
                    Spacer()
                    Spacer()
                } //HStack
                Spacer()
                
                CustomButton(action: {
                    withAnimation(.easeInOut) {
                        self.isOn.toggle()
                    }
                }) {
                    Text("My Button")
                }
                if isOn {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.red)
                        .frame(width: 100, height: 100)
                        .transition(.moveAndFade)
                }
                
                Spacer()
            } //VStack
        }
    }
}
