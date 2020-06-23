//
//  MainScreenCatalyst.swift
//  AppCatalyst
//
//  Created by Максим Сытый on 23.06.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct MainScreenCatalyst: View {
    
    var body: some View {
        AlgoTypesView().environmentObject(AlgoTypesVM())
    }
}

struct MainScreenCatalyst_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenCatalyst()
    }
}
