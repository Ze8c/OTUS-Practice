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
    
    @State var algo: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Algorithms")
                    .fontWeight(.bold)
                    .font(.system(size: 30))

                TextField("", text: Binding<String>(get: {
                    self.algo
                }, set: {
                    self.algo = $0
                    self.vm.updateList(search: $0)
                }))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 200)
                    .padding(10)
                
                List(vm.list, id: \.self) { it in
                    NavigationLink(destination: AlgoTestView()
                        .environmentObject(AlgoTestVM(structure: it))) {
                            Text(it.rawValue.capitalized)
                    }
                }
            } //VStack
        } //NavigationView
    }
}

struct AlgoTypesView_Previews: PreviewProvider {
    static var previews: some View {
        AlgoTypesView().environmentObject(AlgoTypesVM())
    }
}
