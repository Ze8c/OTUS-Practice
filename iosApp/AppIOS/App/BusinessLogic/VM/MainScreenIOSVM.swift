//
//  MainScreenIOSVM.swift
//  OTUS-Practice
//
//  Created by Максим Сытый on 09.07.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation

final class MainScreenIOSVM: ObservableObject {
    
    let algoVM: AlgoTypesVM
    let view3DVM: View3DVM
    let reduxStore: Store<Int, ActionReduxView>
    let animeVM: ProductVM
    
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
        
        animeVM = ProductVM(serviceAPI: AnimeAPIImpl(), db: DBImpl())
    }
}
