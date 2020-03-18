//
//  DetailInfo.swift
//  OTUS-Practice
//
//  Created by Mak on 04.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct DetailInfo: View {
    
    @State var isOn: Bool = false
    
    var element: Product
    
    var body: some View {
        VStack {
            HStack {
                KFImage(element.imgURL)
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                    .cornerRadius(12)
                    .padding([.horizontal, .vertical], 10)
                
                VStack {
                    Text(element.title ?? "")
                        .font(.title)
                        .padding(.vertical, 5)
                    
                    HStack {
                        Text("Members: \(element.members ?? 0)")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("Rating: \(element.score ?? 0.0)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    } //HStack
                        .padding(.bottom, 5)
                } //VStack
                    .padding(.trailing, 10)
            } //HStack
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: .gray, radius: 5, x: 1, y: 1)
                .padding(.horizontal, 5)
                .padding(.top, 25)
            
            Button(action: {
                withAnimation(.easeInOut) {
                    self.isOn.toggle()
                }
            }) {
                Text("About")
            }
                .padding(.top, 15)
            
            if isOn {
                Group {
                    Text(element.synopsis ?? "")
                        .font(.body)
                        .padding([.horizontal, .vertical], 20)
                } //Group
                    .background(Color.white)
                    .transition(.moveAndFade)
                    .cornerRadius(12)
                    .shadow(color: .gray, radius: 4, x: 1, y: 1)
                    .padding([.top, .horizontal], 5)
            }
            
            Spacer()
        } //VStack
    }
}
