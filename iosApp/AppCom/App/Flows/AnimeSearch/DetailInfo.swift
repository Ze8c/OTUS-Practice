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
    
    var element: ProductDB
    
    var body: some View {
        VStack {
            StretchyHeader(header: {
                KFImage(element.imgURL).configure { img in
                    img.resizable()
                }
                .aspectRatio(contentMode: .fill)
            }) {
                Group {
                    Button(action: {
                        withAnimation(.easeInOut) {
                            self.isOn.toggle()
                        }
                    }) {
                        Text("About")
                    }
                        .padding(.top, 25)
                    
                    if isOn {
                        Group {
                            Text(element.synopsis)
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
                } //Group
            } //StretchyHeader
        } //VStack
    }
}

struct DetailInfo_Previews: PreviewProvider {
    static var previews: some View {
        DetailInfo(element: Badge_Previews.itemStub)
    }
}
