//
//  IOSTests.swift
//  IOSTests
//
//  Created by Максим Сытый on 09.07.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import XCTest
@testable import Practice

class IOSTests: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testReducerIntIncrement() throws {
        XCTAssertEqual(1, reducerInt(0, .increment))
    }
    
    func testReducerIntDecrement() throws {
        XCTAssertEqual(0, reducerInt(1, .decrement))
    }

    func testPerformanceExample() throws {
        measure {
            
        }
    }
}
