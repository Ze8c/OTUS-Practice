import XCTest
@testable import ServiceLocator

protocol StubClass: class {
    var txt: String { get }
}

final class StubClassImpl: StubClass {
    var txt: String {
        "Hello"
    }
}

final class ServiceLocatorTests: XCTestCase {
    
    var serviceLocator: ServiceLocator!
    
    override func setUp() {
        serviceLocator = ServiceLocatorImpl()
        super.setUp()
    }
    
    override func tearDown() {
        serviceLocator = nil
        super.tearDown()
    }
    
    func testRegistrator() {
        
        serviceLocator.registrator { container in
            container.inject(StubClass.self) { StubClassImpl() }
        }
        
        if let implProtocol: StubClass = serviceLocator.tryGet() {
            XCTAssertEqual("Hello", implProtocol.txt)
        } else {
            XCTFail()
        }
    }

    static var allTests = [
        ("testRegistrator", testRegistrator),
    ]
}
