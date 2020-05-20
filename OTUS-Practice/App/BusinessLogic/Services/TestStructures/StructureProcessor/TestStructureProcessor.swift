//
//  TestStructureProcessor.swift
//  OTUS-Practice
//
//  Created by Mak on 20.05.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation

protocol TestStructureProcessor {
    func setupWithObjectCount(_ objectCount: Int) -> TimeInterval
    func getTableData() -> [(String, TimeInterval)]
}

extension TestStructureProcessor {
    
    func runClosureForTime(methodCalculation: () -> Void, runAfter: () -> Void = {}) -> TimeInterval {
        //Timestamp before
        let startDate = Date()
        
        //Run the closure
        methodCalculation()
        
        //Timestamp after
        let endDate = Date()
        
        //Calculate the interval.
        let interval = endDate.timeIntervalSince(startDate)
        
        runAfter()
        
        return interval
    }
}
