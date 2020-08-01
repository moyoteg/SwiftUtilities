//
//  Date.swift
//  Utilities
//
//  Created by Moi Gutierrez on 7/27/20.
//

import Foundation

public extension Date {

    func millisecondsSince1970(endianess: Endian) -> Int64 {
        switch endianess {
        case .big:
            return Int64(bigEndian: Int64((self.timeIntervalSince1970 * 1000.0).rounded()))
        case .little:
            return Int64(littleEndian: Int64((self.timeIntervalSince1970 * 1000.0).rounded()))
        }
    }

    func millisecondsSince1970(endianess: Endian) -> UInt64 {
        switch endianess {
        case .big:
            return UInt64(bigEndian: UInt64((self.timeIntervalSince1970 * 1000.0).rounded()))
        case .little:
            return UInt64(littleEndian: UInt64((self.timeIntervalSince1970 * 1000.0).rounded()))
        }
    }

    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000.0)
    }

    init(milliseconds: UInt64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000.0)
    }
}
