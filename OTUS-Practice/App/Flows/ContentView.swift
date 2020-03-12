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
}

struct ContentView: View {
    
    @EnvironmentObject var vm: ContactsVM
    
    @State private var selection: Tabs = .second
    
    var body: some View {
        TabView(selection: $selection) {
            FirstView(selectedTab: $selection)
                .tag(Tabs.first)
                .tabItem {
                    Image(systemName: "escape")
                    Text("1")
                }
            
            SecondView()
                .tag(Tabs.second)
                .tabItem {
                    Image(systemName: "scope")
                    Text("2")
                }
            
            ThirdView()
                .tag(Tabs.third)
                .tabItem {
                    Image(systemName: "burn")
                    Text("3")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ContactsVM())
    }
}
