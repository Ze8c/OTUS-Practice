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
    
    var element: Anime
    
    var body: some View {
        Group {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    
                    KFImage(element.imgURL)
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                        .cornerRadius(12)
                    
                    Spacer()
                    VStack {
                        Text(element.title ?? "")
                            .font(.title)
                        
                        HStack {
                            Text("Episodes: \(element.episodes ?? 0)")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Spacer()
                            Text("Rating: \(element.score ?? 0.0)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        } //HStack
                    } //VStack
                    Spacer()
                    Spacer()
                }
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: .gray, radius: 5, x: 1, y: 1)//HStack
                
                Button(action: {
                    withAnimation(.easeInOut) {
                        self.isOn.toggle()
                    }
                }) {
                    Text("About")
                }
                
                if isOn {
                    Text(element.synopsis ?? "")
                        .font(.body)
                        .background(Color.white)
                        .transition(.moveAndFade)
                        .cornerRadius(12)
                        .shadow(color: .gray, radius: 4, x: 1, y: 1)
                }
                
                Spacer()
            } //VStack
        }
    }
}
