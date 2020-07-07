//
//  MainScreenWatch.swift
//  WatchApp Extension
//
//  Created by Максим Сытый on 22.06.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct MainScreenWatch: View {
    
    var body: some View {
        AlgoTypesWatch().environmentObject(AlgoTypesVM())
    }
}

struct MainScreenWatch_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenWatch()
    }
}
