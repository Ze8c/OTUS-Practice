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
    let reduxStore: Store<Int, ActionReduxView>
    
    init() {
        algoVM = AlgoTypesVM()
        view3DVM = View3DVM()
        
        reduxStore = Store<Int, ActionReduxView>(initialState: 0) { prevState, action in
            switch action {
            case .increment:
                return prevState + 1
            case .decrement:
                return prevState - 1
            }
        }
    }
}
