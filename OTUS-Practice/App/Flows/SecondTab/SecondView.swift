//
//  SecondView.swift
//  OTUS-Practice
//
//  Created by Mak on 04.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct SecondView: View {
    
    @EnvironmentObject var vm: AnimeVM
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.list, id: \.self) { item in
                    NavigationLink(destination: LazyView(DetailInfo(element: item))
                        .navigationBarTitle("Detail info", displayMode: .inline), tag: item.id, selection: self.$vm.selected) {
                            HStack {
                                Text(item.title ?? "")
                            }
                    }
                    .onAppear() {
                        if self.vm.list.isLast(item) {
                            self.vm.getAnime()
                        }
                    }//NavigationLink
                }
            }.onAppear(perform: {
                self.vm.getAnime()
            }) //List
                .navigationBarTitle("Anime")
        }
    }
}
