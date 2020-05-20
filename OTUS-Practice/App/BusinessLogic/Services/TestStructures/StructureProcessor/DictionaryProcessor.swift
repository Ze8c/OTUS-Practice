//
//  DictionaryProcessor.swift
//  OTUS-Practice
//
//  Created by Mak on 20.05.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation

final class DictionaryProcessor: TestStructureProcessor {
    
    private var intDictionary = [Int: Int]()
    
    func getTableData() -> [(String, TimeInterval)] {
        return[("Add 1", add1Entry()),
               ("Add 5", add5Entries()),
               ("Add 10", add10Entries()),
               ("Remove 1O", remove1Entry()),
               ("Remove 5", remove5Entries()),
               ("Remove 10", remove10Entries()),
               ("Lookup 1", lookup1EntryTime()),
               ("Lookup 10", lookup10EntriesTime())]
    }

    
    //MARK: Setup
    
    func setupWithObjectCount(_ count: Int) -> TimeInterval {
        
        intDictionary = [Int: Int]()
        
        return runClosureForTime(methodCalculation: {
            for i in 0 ..< count {
                self.intDictionary.updateValue(i, forKey: i)
            }
        })
    }
    
    private func nextElement() -> Int {
        return intDictionary.count + 1
    }
    
    //MARK: Adding entries
    
    func addEntries(_ count: Int) -> TimeInterval {
        var array = [Int]()
        let next = nextElement()
        for i in 0 ..< count {
            let plusI = next + i
            array.append(plusI)
        }
        
        return runClosureForTime(methodCalculation: {
            for key in array {
                self.intDictionary.updateValue(key, forKey: key)
            }
        }, runAfter: {
            //Restore to original state
            for key in array {
                intDictionary.removeValue(forKey: key)
            }
        })
    }
    
    func add1Entry() -> TimeInterval {
        return addEntries(1)
    }
    
    func add5Entries() -> TimeInterval {
        return addEntries(5)
    }
    
    func add10Entries() -> TimeInterval {
        return addEntries(10)
    }
    
    //MARK: Removing entries
    
    func removeEntries(_ count: Int) -> TimeInterval {
        var array = [Int]()
        let next = nextElement()
        for i in 0 ..< count {
            let plusI = next + i
            array.append(plusI)
        }
        
        for key in array {
            intDictionary.updateValue(key, forKey: key)
        }
        
        return runClosureForTime(methodCalculation: {
            //Restore to original state
            for key in array {
                self.intDictionary.removeValue(forKey: key)
            }
        })
    }
    
    func remove1Entry() -> TimeInterval {
        return removeEntries(1)
    }
    
    func remove5Entries() -> TimeInterval {
        return removeEntries(5)
    }
    
    func remove10Entries() -> TimeInterval {
        return removeEntries(10)
    }
    
    //MARK: Looking up entries
    
    func lookupEntries(_ count: Int) -> TimeInterval {
        var array = [Int]()
        let next = nextElement()
        for i in 0 ..< count {
            let plusI = next + i
            array.append(plusI)
        }
        
        for key in array {
            intDictionary.updateValue(key, forKey: key)
        }
        
        return runClosureForTime(methodCalculation: {
            //Look up by key
            for key in array {
                let _ = self.intDictionary[key]
            }
        }, runAfter: {
            //Restore to original state
            for key in array {
                intDictionary.removeValue(forKey: key)
            }
        })
    }
    
    func lookup1EntryTime() -> TimeInterval {
        return lookupEntries(1)
    }
    
    func lookup10EntriesTime() -> TimeInterval {
        return lookupEntries(10)
    }
}
