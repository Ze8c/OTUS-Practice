//
//  DetailInfo.swift
//  OTUS-Practice
//
//  Created by Mak on 04.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct DetailInfo: View {
    var element: Contact
    
    var body: some View {
        Group {
            
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
                }
                
                Spacer()
                Spacer()
            }
            
            Spacer()
        }
    }
}
