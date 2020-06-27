//
//  MainScreenCatalystVM.swift
//  AppCatalyst
//
//  Created by Максим Сытый on 26.06.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation

final class MainScreenCatalystVM: ObservableObject {
    
    let algoVM: AlgoTypesVM
    let view3DVM: View3DVM
    
    init() {
        algoVM = AlgoTypesVM()
        view3DVM = View3DVM()
    }
}
