//
//  HandleTestAndButton.swift
//  OTUS-Practice
//
//  Created by Максим Сытый on 23.06.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct HandleTestAndButton: View {
    
    let title: String
    let disableBtn: Bool
    let btnAction: () -> Void
    
    var body: some View {
        HStack {
            Text(title)
                .multilineTextAlignment(.leading)
            Button(action: btnAction) {
                Text("Start test")
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.orange)
                    .cornerRadius(5)
            }.disabled(disableBtn)
        } //HStack
    }
}

struct HandleTestAndButton_Previews: PreviewProvider {
    static var previews: some View {
        HandleTestAndButton(title: "Test", disableBtn: false, btnAction: {})
    }
}
