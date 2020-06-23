//
//  SetProcessor.swift
//  OTUS-Practice
//
//  Created by Mak on 20.05.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation

final class SetProcessor: TestStructureProcessor {
    
    private var setToManipulate = Set<String>()
    
    func getTableData() -> [(String, TimeInterval)] {
        return[("Add 1", add1Object()),
               ("Add 5", add5Objects()),
               ("Add 10", add10Objects()),
               ("Remove 1", remove1Object()),
               ("Remove 5", remove5Objects()),
               ("Remove 10", remove10Objects()),
               ("Lookup 1", lookup1Object()),
               ("Lookup 10", lookup10Objects())]
    }
    
    func setupWithObjectCount(_ objectCount: Int) -> TimeInterval {
        
        setToManipulate = Set<String>()
        
        return runClosureForTime(methodCalculation: {
            self.setToManipulate = Set<String>(minimumCapacity: objectCount)
            for _ in 0 ..< objectCount {
                self.setToManipulate.insert(String(numbersOfChar: 12))
            }
        })
    }
    
    //MARK: Add tests
    
    private func addObjects(_ count: Int) -> TimeInterval {
        let originalCount = setToManipulate.count
        var objectsArray = [String]()
        for _ in 0 ..< count {
            //Generate the appropriate number of random strings
            objectsArray.append(String(numbersOfChar: 12))
        }
        
        //Add them all to the set, and measure how long it takes.
        return runClosureForTime(methodCalculation: {
            let _ = self.setToManipulate.union(objectsArray)
        }, runAfter: {
            for removeMe in objectsArray {
                self.setToManipulate.remove(removeMe)
            }
            
            //Make sure we're back to where we need to be.
            assert(originalCount == setToManipulate.count, "Set is not back to the original #!")
        })
    }
    
    func add1Object() -> TimeInterval {
        return addObjects(1)
    }
    
    func add5Objects() -> TimeInterval {
        return addObjects(5)
    }
    
    func add10Objects() -> TimeInterval {
        return addObjects(10)
    }
    
    //MARK: Remove tests
    
    private func removeObjects(_ count: Int) -> TimeInterval {
        let originalCount = setToManipulate.count
        var objectsArray = [String]()
        for _ in 0 ..< count {
            //Generate the appropriate number of random strings
            objectsArray.append(String(numbersOfChar: 12))
        }
        //Add them all to the set
        let _ = self.setToManipulate.union(objectsArray)
        
        //measure how long it takes to remove them.
        return runClosureForTime(methodCalculation: {
            for removeMe in objectsArray {
                self.setToManipulate.remove(removeMe)
            }
        }, runAfter: {
            //Make sure we're back to where we need to be.
            assert(originalCount == setToManipulate.count, "Set is not back to the original #!")
        })
    }
    
    func remove1Object() -> TimeInterval {
        return removeObjects(1)
    }
    
    func remove5Objects() -> TimeInterval {
        return removeObjects(5)
    }
    
    func remove10Objects() -> TimeInterval {
        return removeObjects(10)
    }
    
    //MARK: Lookup tests
    
    private func lookupObjects(_ count: Int) -> TimeInterval {
        let originalCount = setToManipulate.count
        var objectsArray = [String]()
        for _ in 0 ..< count {
            //Generate the appropriate number of random strings
            objectsArray.append(String(numbersOfChar: 12))
        }
        //Add them all to the set
        let _ = self.setToManipulate.union(objectsArray)
        
        //measure how long it takes to find them
        return runClosureForTime(methodCalculation: {
            for findMe in objectsArray {
                let _ = self.setToManipulate.firstIndex(of: findMe)
            }
        }, runAfter: {
            //Remove that which was added
            for removeMe in objectsArray {
                self.setToManipulate.remove(removeMe)
            }
            
            //Make sure we're back to where we need to be.
            assert(originalCount == setToManipulate.count, "Set is not back to the original #!")
        })
    }
    
    func lookup1Object() -> TimeInterval {
        return lookupObjects(1)
    }
    
    func lookup10Objects() -> TimeInterval {
        return lookupObjects(10)
    }
}

