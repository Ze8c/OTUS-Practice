//
//  SavingTest.swift
//  IOSTests
//
//  Created by Максим Сытый on 11.07.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import XCTest
@testable import Practice

class SavingTest: XCTestCase {
    
    var key: String {
        "testRecord"
    }
    
    var value: String {
        "testValue"
    }
    
    var stubProduct: Product {
        let imgURL = "https://cdn.myanimelist.net/images/anime/13/11460.jpg?s=7e890b7e93b7b57c2de4aa90211931bd"
        
        return Product(id: 245,
                       imageUrl: imgURL,
                       title: "Great Teacher Onizuka",
                       synopsis: "Onizuka is a reformed biker gang leader who has his sights set on an honorable new ambition: to become the world's greatest teacher... for the purpose of meeting sexy high school girls. Okay, so he's...",
                       type: "Anime",
                       members: 476501,
                       score: 8.71)
    }

    var fs: DataProvider!
    var uds: DataProvider!
    var db: DBAbstract!

    override func setUp() {
        fs = FileService()
        uds = UserDefaultsService()
        db = DBImpl()
        super.setUp()
    }
    
    override func tearDown() {
        fs = nil
        uds = nil
        db = nil
        super.tearDown()
    }

    func testFileService() throws {
        
        fs.set(to: key, value: value)
        
        XCTAssertEqual(value, fs.get(from: key))
    }
    
    func testUserDefaultsService() throws {
        
        uds.set(to: key, value: value)
        
        XCTAssertEqual(value, uds.get(from: key))
    }
    
    func testDB() throws {
        
        db.save(elements: [stubProduct])
        
        let getProduct: Array<Product> = db.getElements()
        
        XCTAssertTrue(getProduct[0] == stubProduct)
    }
}
