//
//  SecondView.swift
//  OTUS-Practice
//
//  Created by Mak on 04.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct SecondView: View {
    
    @EnvironmentObject var vm: ProductVM
    
    @State private var searchText: String = ""
    @State private var ch1: Bool = true
    @State private var ch2: Bool = false
    @State private var filter: String = "manga"
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Select one filter ")
                        .font(.body)
                        .padding([.leading, .top], 10)
                    
                    CustomButton(isOn: $ch1, name: "Manga", action: { filter in
                        self.filter = filter
                        self.ch2.toggle()
                        self.searchProduct()
                    }) { name in
                        Text(name)
                    }
                    .cornerRadius(12)
                    .padding([.leading, .top], 10)
                    
                    CustomButton(isOn: $ch2, name: "Anime", action: { filter in
                        self.filter = filter
                        self.ch1.toggle()
                        self.searchProduct()
                    }) { name in
                        Text(name)
                    }
                    .cornerRadius(12)
                    .padding([.leading, .top], 10)
                    
                    Spacer()
                } //HStack
                    .padding(.top, 10)
                
                TextField("Search text", text: $searchText, onCommit: {
                    self.searchProduct()
                })
                    .keyboardType(.webSearch)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.horizontal, .bottom], 5)
                
                if vm.list.isEmpty {
                    Spacer()
                } else {
                    List {
                        ForEach(vm.list, id: \.self) { item in
                            NavigationLink(destination: LazyView(DetailInfo(element: item))
                                .navigationBarTitle("Detail info", displayMode: .inline), tag: item.id, selection: self.$vm.selected) {
                                    HStack {
                                        //Text(item.title ?? "")
                                        Badge(model: item)
                                    }
                            }
                            .onAppear() {
                                if self.vm.list.isLast(item) {
                                    self.vm.getAnime()
                                }
                            }//NavigationLink
                        }
                    } //List
                }
            } //VStack
                .navigationBarTitle("Search")
        } //NavigationView
        .padding(5.0)
    }
    
    private func searchProduct() {
        self.vm.getAnime(self.searchText, filter: self.filter)
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
            .environmentObject(ProductVM())
    }
}
