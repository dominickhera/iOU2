import XCTest
@testable import iOU2

final class iOU2Tests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(iOU2().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
