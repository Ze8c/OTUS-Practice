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
                
                testAlgo(title: "Testing algorithms for 10 000 items", vm)
                    .padding([.horizontal, .bottom], 10)
                
                List(vm.list, id: \.self) { it in
                    NavigationLink(destination: AlgoTestView()
                        .environmentObject(AlgoTestVM(structure: it))) {
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
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 200)
        } //VStack
    }
    
    private func testAlgo(title: String, _ vm: AlgoTypesVM) -> some View {
        HStack {
            Text(title)
                .multilineTextAlignment(.leading)
            Button(action: vm.test) {
                Text("Start test")
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.orange)
                    .cornerRadius(5)
            }.disabled(vm.disableToStart)
        } //HStack
    }
}

struct AlgoTypesView_Previews: PreviewProvider {
    static var previews: some View {
        AlgoTypesView().environmentObject(AlgoTypesVM())
    }
}
