import XCTest
@testable import Utilities

final class UtilitiesTests: XCTestCase {

    func testByteCount() {
        
        let u64:UInt64 = 1
        
        let dataRepresentation = u64.data
        
        let correctByteCount = 8
        
        XCTAssertEqual(dataRepresentation.count, correctByteCount)
    }
    
    func testDataToHexStringConversion() {
        
        let data = "test".hexadecimal!
        let data2 = data.hexadecimal.hexadecimal
        
        XCTAssertEqual(data, data2)
    }
    
    static var allTests = [
        ("testByteCount", testByteCount),
    ]
}
