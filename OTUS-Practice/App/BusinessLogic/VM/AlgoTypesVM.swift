//
//  AlgoTypesVM.swift
//  OTUS-Practice
//
//  Created by Mak on 20.05.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation

final class AlgoTypesVM: ObservableObject {
    
    @Published var list: Array<Structures> = []
    
    init() {
        updateList()
    }
    
    public func updateList(search: String = "") {
        if search.isEmpty {
            self.list =  Structures.allCases
        } else {
            self.list = Structures.allCases.filter { it in
                it.rawValue.lowercased().hasPrefix(search.lowercased())
            }
        }
    }
}
