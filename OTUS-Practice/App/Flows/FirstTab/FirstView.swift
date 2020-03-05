//
//  FirstView.swift
//  OTUS-Practice
//
//  Created by Mak on 04.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct FirstView: View {
    
    @Binding var selectedTab: Tabs
    
    @EnvironmentObject var vm: ContactsVM
    
    @State var selection: Int = 0
    
    var body: some View {
        VStack {
            Button("Second tab") {
                self.selectedTab = .second
                self.vm.selected = self.selection
            }
            
            HStack {
                Spacer()
                Picker(selection: $selection, label: Text("")) {
                    ForEach(vm.list.indices) { i in
                        Text(self.vm.list[i].name).tag(i)
                    }
                }
                Spacer()
            }
        }
    }
}
