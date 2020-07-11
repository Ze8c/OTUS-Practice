//
//  AlgorithmsPerformanceTest.swift
//  IOSTests
//
//  Created by Максим Сытый on 11.07.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import XCTest
@testable import Practice

class AlgorithmsPerformanceTest: XCTestCase {
    
    var numberElemntsProcessor: Int {
        10_000
    }

    var arrProc: TestStructureProcessor!
    var dictProc: TestStructureProcessor!
    var setProc: TestStructureProcessor!
    var sufArrProc: TestStructureProcessor!

    override func setUp() {
        arrProc = ArrayProcessor()
        dictProc = DictionaryProcessor()
        setProc = SetProcessor()
        sufArrProc = SuffixArrayProcessor()
        super.setUp()
    }
    
    override func tearDown() {
        arrProc = nil
        dictProc = nil
        setProc = nil
        sufArrProc = nil
        super.tearDown()
    }

    func testArrayProcessor() throws {
        
        measure {
            _ = arrProc.setupWithObjectCount(numberElemntsProcessor)
        }
    }
    
    func testArrayProcessorTable() throws {
        
        measure {
            _ = arrProc.getTableData()
        }
    }
    
    func testDictionaryProcessor() throws {
        
        measure {
            _ = dictProc.setupWithObjectCount(numberElemntsProcessor)
        }
    }
    
    func testDictionaryProcessorTable() throws {
        
        measure {
            _ = dictProc.getTableData()
        }
    }
    
    func testSetProcessor() throws {
        
        measure {
            _ = setProc.setupWithObjectCount(numberElemntsProcessor)
        }
    }
    
    func testSetProcessorTable() throws {
        
        measure {
            _ = setProc.getTableData()
        }
    }
    
    func testSuffixArrayProcessor() throws {
        
        measure {
            _ = sufArrProc.setupWithObjectCount(numberElemntsProcessor)
        }
    }
    
    func testSuffixArrayProcessorTable() throws {
        
        measure {
            _ = sufArrProc.getTableData()
        }
    }
}
