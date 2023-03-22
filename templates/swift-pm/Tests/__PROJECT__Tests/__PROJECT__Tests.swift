import XCTest
@testable import ${POD_NAME}

final class ${POD_NAME}Tests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(KeychainInterface().text, "Hello, World!")
    }
}
