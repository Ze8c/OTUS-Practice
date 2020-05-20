//
//  ArrayProcessor.swift
//  OTUS-Practice
//
//  Created by Mak on 20.05.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation

final class ArrayProcessor: TestStructureProcessor {
    
    private var intArray: Array<Int> = []
    
    func getTableData() -> [(String, TimeInterval)] {
        return[("Insert At Beginning", insertNewObjectAtBeginning()),
               ("Insert In Middle", insertNewObjectInMiddle()),
               ("Add At End", addNewObjectAtEnd()),
               ("Remove First", removeFirstObject()),
               ("Remove Middle", removeMiddleObject()),
               ("Remove Last", removeLastObject()),
               ("Lookup By Index", lookupByIndex()),
               ("Lookup By Object", lookupByObject())]
    }
    
    func setupWithObjectCount(_ count: Int) -> TimeInterval {
        
        intArray = []
        
        return runClosureForTime(methodCalculation: {
            intArray = [Int]()
            for i in 0 ..< count {
                self.intArray.append(i)
            }
        })
    }
    
    private func nextElement() -> Int {
        return intArray.count + 1
    }
    
    //MARK: -Addition Tests
    
    func insertNewObjectAtBeginning() -> TimeInterval {
        let next = nextElement()
        return runClosureForTime(methodCalculation: {
            intArray.insert(next, at: 0)
        })
    }
    
    func insertNewObjectInMiddle() -> TimeInterval {
        let middleIndex = intArray.count / 2
        let next = nextElement()
        
        return runClosureForTime(methodCalculation: {
            intArray.insert(next, at: middleIndex)
        })
    }
    
    func addNewObjectAtEnd() -> TimeInterval {
        let next = nextElement()
        return runClosureForTime(methodCalculation: {
            intArray.append(next)
        })
    }
    
    //MARK: -Removal tests
    
    func removeFirstObject() -> TimeInterval {
        return runClosureForTime(methodCalculation: {
            intArray.remove(at: 0)
        })
    }
    
    func removeMiddleObject() -> TimeInterval {
        let middleIndex = intArray.count / 2
        
        return runClosureForTime(methodCalculation: {
            intArray.remove(at: middleIndex)
        })
    }
    
    func removeLastObject() -> TimeInterval {
        intArray.append(nextElement())
        return runClosureForTime(methodCalculation: {
            intArray.removeLast()
        })
    }
    
    //MARK: Lookup tests
    
    func lookupByIndex() -> TimeInterval {
        let elements = UInt32(intArray.count)
        let randomIndex = Int(arc4random_uniform(elements))
        
        return runClosureForTime(methodCalculation: {
            _ = intArray[randomIndex]
        })
    }
    
    func lookupByObject() -> TimeInterval {
        //Add a known object at a random index.
        let next = nextElement()
        let elements = UInt32(intArray.count)
        let randomIndex = Int(arc4random_uniform(elements))
        intArray.insert(next, at: randomIndex)
        
        return runClosureForTime(methodCalculation: {
            let _ = intArray.firstIndex(of: next)
        })
    }
}
