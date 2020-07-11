//
//  StoreTest.swift
//  IOSTests
//
//  Created by Максим Сытый on 09.07.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import XCTest
@testable import Practice

class StoreTest: XCTestCase {
    
    var store: Store<Int, ActionInt>!

    override func setUp() {
        store = Store(initialState: 0, reducer: reducerInt)
        super.setUp()
    }
    
    override func tearDown() {
        store = nil
        super.tearDown()
    }

    func testReducerIntIncrement() throws {
        XCTAssertEqual(1, reducerInt(0, .increment))
    }
    
    func testReducerIntDecrement() throws {
        XCTAssertEqual(0, reducerInt(1, .decrement))
    }
    
    func testStore() throws {
        
        store.dispatch(action: .increment)()
        
        XCTAssertEqual(1, store.state)
    }
}
