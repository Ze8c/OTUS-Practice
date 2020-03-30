//
//  Badge.swift
//  OTUS-Practice
//
//  Created by Mak on 26.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct Badge: View {
    
    var model: Product
    
    var body: some View {
        HStack {
            KFImage(model.imgURL)
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .cornerRadius(12)
                .padding([.horizontal, .vertical], 10)
            
            VStack {
                Text(model.title ?? "")
                    .font(.title)
                    .padding(.vertical, 5)
                
                HStack {
                    Text("Members: \(model.members ?? 0)")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("Rating: \(model.score ?? 0.0)")
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
    }
}

struct Badge_Previews: PreviewProvider {
    static let imgURL = "https://cdn.myanimelist.net/images/anime/13/22128.jpg?s=08c2b1b4a465fc43cbe15aae4a425b78"
    static let itemStub: Product = Product(malId: 4224,
                                           imageUrl: imgURL,
                                           title: "Toradora!",
                                           synopsis: "Ryuuji Takasu is a gentle...",
                                           members: 1191008,
                                           score: 8.3300000000000001)
    
    static var previews: some View {
        Badge(model: itemStub)
    }
}
