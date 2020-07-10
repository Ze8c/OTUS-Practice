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
    let reduxStore: Store<Int, ActionInt>
    let animeVM: ProductVM
    
    init() {
        algoVM = AlgoTypesVM()
        view3DVM = View3DVM()
        reduxStore = Store<Int, ActionInt>(initialState: 0, reducer: reducerInt)
        animeVM = ProductVM(serviceAPI: AnimeAPIImpl(), db: DBImpl())
    }
}
