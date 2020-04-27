//
//  FirstView.swift
//  OTUS-Practice
//
//  Created by Mak on 04.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct FirstView: View {
    
    @EnvironmentObject var vm: ProductVM
    
    @State private var searchText: String = ""
    @State private var searchFilter: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                FilteringString(filter: $searchFilter, filters: vm.filters) {
                    Text("Select one filter ")
                }
                
                TextField("Search text", text: $searchText, onCommit: {
                    self.vm.filter = self.searchFilter
                    self.vm.query = self.searchText
                })
                    .keyboardType(.webSearch)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.horizontal, .bottom], 5)
                
                if vm.list.isEmpty {
                    Spacer()
                    if !vm.isLoaded {
                        Spiner()
                        Spacer()
                    }
                } else {
                    List {
                        ForEach(vm.list, id: \.self) { item in
                            NavigationLink(destination: LazyView(DetailInfo(element: item))
                                .navigationBarTitle("Detail info", displayMode: .inline), tag: item.id, selection: self.$vm.selected) {
                                    HStack {
                                        Badge(model: item)
                                    }
                            }
                            .onAppear() {
                                self.vm.lastAppearElement = item
                            } //NavigationLink
                        }
                    } //List
                }
                    
                
            } //VStack
                .navigationBarTitle("Search")
        } //NavigationView
        .padding(5.0)
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
            .environmentObject(ProductVM(serviceAPI: AnimeAPIImpl(), db: DBImpl()))
    }
}
