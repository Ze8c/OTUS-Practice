//
//  AlgoTestVM.swift
//  OTUS-Practice
//
//  Created by Mak on 20.05.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation

final class AlgoTestVM: ObservableObject {
    
    @Published var typeStructure: Structures
    @Published var list = [(String, TimeInterval)]()
    @Published var createElements: String = ""
    @Published var ableToStart = true
    private var number = 1
    private let processor: TestStructureProcessor
    
    init(structure: Structures) {
        self.typeStructure = structure
        processor = structure.processor
    }
    
    func startTest() {
        self.ableToStart = false
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let timeInterval = self.processor.setupWithObjectCount(self.number)
            self.createElements = ", created: \(String(ceil(timeInterval * 10000) / 10000))"
            self.list = self.processor.getTableData()
            self.ableToStart = true
        }
    }
    
    func getNumberOfItems(_ value: Float) -> Int {
        var numberOfItems = Int(ceil(powf(value * 100.0, 3)))
        if (numberOfItems > 100000) {
            numberOfItems = Int(ceil(Float(numberOfItems) / 1000)) * 1000
        }
        self.number = numberOfItems
        return numberOfItems
    }
}
