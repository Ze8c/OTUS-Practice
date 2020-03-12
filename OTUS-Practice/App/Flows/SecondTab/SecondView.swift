//
//  SecondView.swift
//  OTUS-Practice
//
//  Created by Mak on 04.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct SecondView: View {
    
    @EnvironmentObject var vm: ContactsVM
    
    @State var radish: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                SwitchCell(radish: $radish)
                    .environmentObject(vm)
                
                List {
                    ForEach(vm.list) { item in
                        if !self.radish || item.isRadish {
                            NavigationLink(destination: LazyView(DetailInfo(element: item))
                                .navigationBarTitle("Detail info", displayMode: .inline), tag: item.id, selection: self.$vm.selected) {
                                    HStack {
                                        Image(systemName: item.imgName)
                                            .foregroundColor(item.imgColor)
                                        Text(item.name)
                                    }
                            } //NavigationLink
                        }
                    }
                } //List
                .navigationBarTitle("Contacts")
            } //VStack
        }
    }
}
