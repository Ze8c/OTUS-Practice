//
//  SuffixArrayProcessor.swift
//  OTUS-Practice
//
//  Created by Mak on 20.05.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation

final class SuffixArrayProcessor: TestStructureProcessor {
    
    private var setToSearch = Set<String>()
    
    private var suffixArray: [(suffix: String, algoName: String)] = []
    
    func getTableData() -> [(String, TimeInterval)] {
        
        let resultE1 = searchEqualEntry(1)
        let resultE5 = searchEqualEntry(5)
        let resultE10 = searchEqualEntry(10)
        let resultS1 = searchStartEntry(1)
        let resultS5 = searchStartEntry(5)
        let resultS10 = searchStartEntry(10)
        
        return[("Search 1 count: \(resultE1.count)", resultE1.time),
               ("Search 5 count: \(resultE5.count)", resultE5.time),
               ("Search 10 count: \(resultE10.count)", resultE10.time),
               ("Search 1 Start count: \(resultS1.count)", resultS1.time),
               ("Search 5 Start count: \(resultS5.count)", resultS5.time),
               ("Search 10 Start count: \(resultS10.count)", resultS10.time)]
    }
    
    func setupWithObjectCount(_ objectCount: Int) -> TimeInterval {
        
        setToSearch = Set<String>()
        
        for _ in 0..<10 {
            setToSearch.insert(String(numbersOfChar: 3))
        }
        
        return runClosureForTime(methodCalculation: {
            var tuples: [(suffix: String, algoName: String)] = []
            
            outerLabel: while tuples.count < objectCount {
                for algo in AlgoProvider().all {
                    let trimedAlgo = algo.filter(String.alphanumeric.contains)
                    let suffixSequence = SuffixSequence(string: trimedAlgo)
                    for subString in suffixSequence {
                        tuples.append((String(subString), algo))
                        if tuples.count >= objectCount {
                            break outerLabel
                        }
                    }
                }
            }
            
            tuples.sort { $0.suffix < $1.suffix }
            suffixArray = tuples
        })
    }
    
    private func searchEqualEntry(_ count: Int) -> (count: Int, time: TimeInterval) {
        var counter: Int = 0
        var iterator: Int = 0
        return (counter, runClosureForTime(methodCalculation: {
            for gen in setToSearch {
                for it in suffixArray {
                    if it.suffix.contains(gen) {
                        counter += 1
                    }
                }
                iterator += 1
                if iterator == count { break }
            }
        }))
    }
    
    private func searchStartEntry(_ count: Int) -> (count: Int, time: TimeInterval) {
        var counter: Int = 0
        var iterator: Int = 0
        return (counter, runClosureForTime(methodCalculation: {
            for gen in setToSearch {
                for it in suffixArray {
                    if (it.suffix.starts(with: gen)) {
                        counter += 1
                    }
                }
                iterator += 1
                if iterator == count { break }
            }
        }))
    }
}
