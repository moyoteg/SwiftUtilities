import XCTest
@testable import Utilities

final class UtilitiesTests: XCTestCase {

    func testByteCount() {
        
        let u64:UInt64 = 1
        
        let dataRepresentation = u64.data
        
        let byteCount = 8
        
        XCTAssertEqual(dataRepresentation.count, byteCount)
    }
    
    static var allTests = [
        ("testByteCount", testByteCount),
    ]
}
