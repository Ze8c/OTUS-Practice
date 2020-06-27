//
//  MainScreenCatalyst.swift
//  AppCatalyst
//
//  Created by Максим Сытый on 23.06.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct MainScreenCatalyst: View {
    
    @EnvironmentObject var vm: MainScreenCatalystVM
    
    var body: some View {
        TabView() {
            AlgoTypesView()
                .environmentObject(vm.algoVM)
                .tabItem {
                    Image(systemName: "checkmark.seal")
                    Text("1")
                }
            
            View3D()
                .environmentObject(vm.view3DVM)
                .tabItem {
                    Image(systemName: "view.3d")
                    Text("2")
                }
        }
    }
}

struct MainScreenCatalyst_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenCatalyst()
    }
}
