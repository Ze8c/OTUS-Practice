import XCTest
@testable import ServiceLocator

final class ServiceLocatorTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ServiceLocator().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
