//
//  AlgoTypesView.swift
//  OTUS-Practice
//
//  Created by Mak on 20.05.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct AlgoTypesView: View {
    
    @EnvironmentObject var vm: AlgoTypesVM
    
    @State var algo: String = "" {
        didSet {
            vm.updateList(search: algo)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 5) {
                search(name: "Algorithms", text: $algo)
                    .padding(10)
                
                HandleTestAndButton(title: "Testing algorithms for 10 000 items",
                                    disableBtn: vm.disableToStart,
                                    btnAction: vm.test)
                    .padding([.horizontal, .bottom], 10)
                
                List(vm.list, id: \.self) { it in
                    NavigationLink(destination: LazyView(
                        AlgoTestView()
                            .environmentObject(AlgoTestVM(structure: it))
                    )) {
                            CellList(title: it.rawValue.capitalized, result: self.vm.listTest[it])
                    }
                }
            } //VStack
        } //NavigationView
    }
    
    private func search(name: String, text: Binding<String>) -> some View {
        VStack {
            Text(name)
                .fontWeight(.bold)
                .font(.system(size: 30))
            
            TextField("", text: text)
                .frame(width: 200)
        } //VStack
    }
}

struct AlgoTypesView_Previews: PreviewProvider {
    static var previews: some View {
        AlgoTypesView().environmentObject(AlgoTypesVM())
    }
}
