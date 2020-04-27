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
            ZStack {
                KFImage(model.imgURL)
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                    .cornerRadius(12)
                    .padding([.horizontal, .vertical], 10)
                
                Group {
                    Text(model.typeProd.rawValue.capitalized.prefix(1))
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .padding([.all], 3)
                }
                .background(Color(dRed: 155, green: 155, blue: 155).opacity(0.7))
                .cornerRadius(4)
                .offset(x: 36, y: -36)
            }
            
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
    static let imgURL = "https://cdn.myanimelist.net/images/anime/13/11460.jpg?s=7e890b7e93b7b57c2de4aa90211931bd"
    static let itemStub: Product = Product(id: 245,
                                           imageUrl: imgURL,
                                           title: "Great Teacher Onizuka",
                                           synopsis: "Onizuka is a reformed biker gang leader who has his sights set on an honorable new ambition: to become the world's greatest teacher... for the purpose of meeting sexy high school girls. Okay, so he's...",
                                           type: "Anime",
                                           members: 476501,
                                           score: 8.71)
    
    static var previews: some View {
        Badge(model: itemStub)
    }
}
