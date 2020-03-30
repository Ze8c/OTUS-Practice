//
//  NextSecondView.swift
//  OTUS-Practice
//
//  Created by Mak on 17.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct NextSecondView: View {
    
    var body: some View {
        VStack{
            HStack{
                NavPopButton(destination: .previous) {
                    Text("Pop to Previous (1)")
                }
                Spacer()
                NavPopButton(destination: .root) {
                    Text("Pop to Root")
                }
                Spacer()
                Spacer()
            }
            ColumnView()
                .environmentObject(ColumnVM())
        }
        .background(Color.yellow)
    }
}
