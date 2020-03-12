//
//  ThirdView.swift
//  OTUS-Practice
//
//  Created by Mak on 04.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct ThirdView: View {
    
    @State var isModal: Bool = false
    
    var body: some View {
        VStack {
            Button("Modal") {
                self.isModal = true
            }.sheet(isPresented: $isModal, content: {
                LazyView(ColumnView()
                    .environmentObject(ColumnVM()))
            })
        }
    }
}

struct ThirdView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdView()
    }
}
