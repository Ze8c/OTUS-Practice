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
                
                List(vm.list.filter({ !self.radish || $0.isRadish })) { item in
                    NavigationLink(destination: LazyView(DetailInfo(element: item))
                        .navigationBarTitle("Detail info", displayMode: .inline)) {
                            HStack{
                                Image(systemName: item.imgName).foregroundColor(item.imgColor)
                                Text(item.name)
                            }
                    }
                }.navigationBarTitle("Contacts")
            }
        }
    }
}
