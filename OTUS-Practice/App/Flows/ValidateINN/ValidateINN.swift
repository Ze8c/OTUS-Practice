//
//  ValidateINN.swift
//  OTUS-Practice
//
//  Created by Mak on 12.05.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct ValidateINN: View {
    
    @State private var validateText: String = ""
    
    let validReg: String = #"^[0-9]{4}[-\s]?[0-9]{6}(?:[0-9]{2})?$"#
    
    var contentColorOn: Color = .init(dRed: 16, green: 130, blue: 23)
    var colorOn: Color = .init(dRed: 100, green: 228, blue: 108)
    var contentColorOff: Color = .init(dRed: 53, green: 53, blue: 53)
    var colorOff: Color = .init(dRed: 184, green: 184, blue: 184)
    
    var body: some View {
        VStack {
            TextField("Validate INN", text: $validateText)
                .keyboardType(.webSearch)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding([.horizontal, .top], 5)
            ZStack {
                Text(validateText.valid(regExStr: validReg) ? "Valid" : "Invalid")
                    .foregroundColor(validateText.valid(regExStr: validReg) ? contentColorOn : contentColorOff)
                    .font(.body)
                    .padding(.all, 5)
            }
                .background(validateText.valid(regExStr: validReg) ? colorOn : colorOff)
                .cornerRadius(12)
            
            Spacer()
        }
    }
}

struct ValidateINN_Previews: PreviewProvider {
    static var previews: some View {
        ValidateINN()
    }
}
