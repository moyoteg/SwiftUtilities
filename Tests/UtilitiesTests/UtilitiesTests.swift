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
        
        let string = "hello world"
        
        let stringToCompare = String(hexadecimal: string.asHexadecimalString()!)
                
        // is data the same when converting it from string to hexData and back?
        XCTAssertEqual(string, stringToCompare)
    }
    
    func testStringToHexStringConversion() {
        
        let string = "hello world"
        
        let correctConvertedHexString = "68656c6c6f20776f726c64" // "hello world" in hex
        
        // is string converted to hex string correct?
        XCTAssertEqual(string.asHexadecimalString(), correctConvertedHexString)
    }
        
    static var allTests = [
        ("testByteCount", testByteCount),
        ("testDataToHexStringConversion", testDataToHexStringConversion),
    ]
}
