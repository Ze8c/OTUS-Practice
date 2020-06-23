//
//  CellList.swift
//  OTUS-Practice
//
//  Created by Mak on 11.06.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct CellList: View {
    
    private let title: String
    private let time: String
    private let colotTime: Color
    
    var body: some View {
        HStack{
            Text(title)
            Spacer()
            Group {
                Text(time)
                    .foregroundColor(.black)
                    .background(colotTime)
                    .padding(5)
            }
                .cornerRadius(5)
        }
    }
    
    init(title: String, result: (time: Double, color: Color)?) {
        
        if let r = result {
            self.time = String(ceil(r.time * 10000) / 10000)
            self.colotTime = r.color
        } else {
            self.time = "0.0"
            self.colotTime = .red
        }
        self.title = title
    }
}

struct CellList_Previews: PreviewProvider {
    static var previews: some View {
        CellList(title: "Max", result: (0.32, .yellow))
    }
}
