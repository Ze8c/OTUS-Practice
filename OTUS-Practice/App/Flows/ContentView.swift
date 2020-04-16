//
//  ContentView.swift
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

struct ContentView: View {
    
    @EnvironmentObject var vm: ProductVM
    
    @State private var selection: Tabs = .first
    
    var body: some View {
        TabView(selection: $selection) {
            FirstView()
                .tag(Tabs.first)
                .tabItem {
                    Image(systemName: "scope")
                    Text("1")
                }
            
            SecondView()
                .tag(Tabs.second)
                .tabItem {
                    Image(systemName: "burn")
                    Text("2")
                }
            ThirdView()
                .tag(Tabs.third)
                .tabItem {
                    Image(systemName: "flame")
                    Text("3")
                }
        }
    }
}
