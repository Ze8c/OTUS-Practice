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
                    Text("Algorithms")
                }
            
            View3D()
                .environmentObject(vm.view3DVM)
                .tabItem {
                    Image(systemName: "view.3d")
                    Text("Metal")
                }
            
            ReduxView()
                .environmentObject(vm.reduxStore)
                .tabItem {
                    Image(systemName: "arrow.3.trianglepath")
                    Text("Redux")
                }
            
            AnimeSearch()
                .environmentObject(vm.animeVM)
                .tabItem {
                    Image(systemName: "a")
                    Text("Anime")
                }
        }
    }
}

struct MainScreenCatalyst_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenCatalyst().environmentObject(MainScreenCatalystVM())
    }
}
