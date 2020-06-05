import XCTest
@testable import Utilities

final class UtilitiesTests: XCTestCase {

    func testByteCount() {
        
        let u64:UInt64 = 1
        
        let dataRepresentation = u64.data
        
        let correctByteCount = 8

        // is byte count correct when converting UInt64 to data?
        XCTAssertEqual(dataRepresentation.count, correctByteCount)
    }
    
    func testDataToHexStringConversion() {
        
        let data = "test".hexadecimal!
        let data2 = data.hexadecimal.hexadecimal
        
        // is data the same when converting it from string to hexData and back?
        XCTAssertEqual(data, data2)
    }
    
    static var allTests = [
        ("testByteCount", testByteCount),
        ("testDataToHexStringConversion", testDataToHexStringConversion),
    ]
}
