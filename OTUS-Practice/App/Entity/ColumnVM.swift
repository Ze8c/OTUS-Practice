//
//  ColumnVM.swift
//  OTUS-Practice
//
//  Created by Mak on 12.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation
import Combine

final class ColumnVM: ObservableObject {
    
    @Published private(set) var elements = [[Int]]()
    
    init() {
        let coll = (1...30).publisher.collect(3)
        _ = coll.collect().sink {
            self.elements = $0
        }
    }
}
