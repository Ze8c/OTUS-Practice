//
//  MainScreenIOS.swift
//  OTUS-Practice
//
//  Created by Mak on 03.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

enum Tabs: Hashable {
    case first
    case second
    case third
    case fourth
}

struct MainScreenIOS: View {
    
    @EnvironmentObject var vm: MainScreenIOSVM
    
    @State private var selection: Tabs = .first
    
    var body: some View {
        TabView(selection: $selection) {
            AnimeSearch()
                .environmentObject(vm.animeVM)
                .tag(Tabs.first)
                .tabItem {
                    Image(systemName: "scope")
                    Text("Anime")
                }
            /*
            LocaliseTextView()
                .environmentObject(LocaliseTextVM(withService: SharingService()))
                .tag(Tabs.second)
                .tabItem {
                    Image(systemName: "doc.plaintext")
                    Text("2")
                }
            */
            AlgoTypesView()
                .environmentObject(vm.algoVM)
                .tag(Tabs.second)
                .tabItem {
                    Image(systemName: "checkmark.seal")
                    Text("Algorithms")
                }
            ReduxView()
                .environmentObject(vm.reduxStore)
                .tag(Tabs.third)
                .tabItem {
                    Image(systemName: "arrow.3.trianglepath")
                    Text("Redux")
                }
        }
    }
    
    mutating func change(tab: Tabs) {
        selection = tab
    }
}

struct MainScreenIOS_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenIOS()
            .environmentObject(MainScreenIOSVM())
    }
}
