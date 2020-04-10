//
//  FilteringString.swift
//  OTUS-Practice
//
//  Created by Mak on 07.04.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct FilteringString<L: View>: View {
    
    @Binding var filter: String
    
    var filters: Array<String>
    let label: () -> (L)
    
    var body: some View {
        HStack {
            label()
                .font(.body)
                .padding([.leading, .top], 10)
            
            ForEach(filters.indices) { it in
                CustomButton(selected: self.$filter, name: self.filters[it].capitalized)
                    .cornerRadius(12)
                    .padding([.leading, .top], 10)
            }
            
            Spacer()
        } //HStack
            .padding(.top, 10)
    }
}

struct FilteringString_Previews: PreviewProvider {
    
    @State static var tmpName: String = ""
    
    static var previews: some View {
        FilteringString(filter: $tmpName, filters: ["Manga", "Anime"]) {
            Text("Select one filter ")
        }
    }
}
