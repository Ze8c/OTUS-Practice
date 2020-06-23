//
//  AlgoTypesWatch.swift
//  WatchApp Extension
//
//  Created by Максим Сытый on 23.06.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct AlgoTypesWatch: View {
    
    @EnvironmentObject var vm: AlgoTypesVM
    
    var body: some View {
        VStack(spacing: 5) {
            HandleTestAndButton(title: "Testing 10 000 items",
                                disableBtn: vm.disableToStart,
                                btnAction: vm.test)
                .padding([.horizontal, .bottom], 2)
            
            List(vm.list, id: \.self) { it in
                CellList(title: it.nameForWatch, result: self.vm.listTest[it])
            }
        } //VStack
    }
}

struct AlgoTypesWatch_Previews: PreviewProvider {
    static var previews: some View {
        AlgoTypesWatch().environmentObject(AlgoTypesVM())
    }
}
