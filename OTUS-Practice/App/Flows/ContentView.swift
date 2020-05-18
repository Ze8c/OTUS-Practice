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
            LocalizeTextView()
                .environmentObject(LocalizeTextVM(withService: SharingService()))
                .tag(Tabs.second)
                .tabItem {
                    Image(systemName: "doc.plaintext")
                    Text("2")
                }
        }
    }
    
    mutating func change(tab: Tabs) {
        selection = tab
    }
}
