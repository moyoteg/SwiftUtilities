//
//  IntExternsions.swift
//  Utilities
//
//  Created by Moi Gutierrez on 6/4/20.
//

import Foundation

public extension Int {
    var boolValue: Bool {
        return self != 0
    }
}

public extension Int {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<Int>.size)
    }
}

public extension Int64 {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<Int64>.size)
    }
}

public extension Int8 {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<Int8>.size)
    }
}

public extension UInt8 {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<UInt8>.size)
    }
}

public extension UInt16 {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<UInt16>.size)
    }
}

public extension UInt32 {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<UInt32>.size)
    }
    
    var byteArrayLittleEndian: [UInt8] {
        return [
            UInt8((self & 0xFF000000) >> 24),
            UInt8((self & 0x00FF0000) >> 16),
            UInt8((self & 0x0000FF00) >> 8),
            UInt8( self & 0x000000FF)
        ]
    }
}

public extension UInt64 {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<UInt64>.size)
    }
    
    var byteArrayLittleEndian: [UInt8] {
        return [
            UInt8((self & 0xFF00000000000000) >> 56),
            UInt8((self & 0x00FF000000000000) >> 48),
            UInt8((self & 0x0000FF0000000000) >> 40),
            UInt8((self & 0x000000FF00000000) >> 32),
            UInt8((self & 0x00000000FF000000) >> 24),
            UInt8((self & 0x0000000000FF0000) >> 16),
            UInt8((self & 0x000000000000FF00) >> 8),
            UInt8( self & 0x00000000000000FF)
        ]
    }
}

public extension UnsignedInteger {
    
    init(_ bytes: [UInt8]) {
        
        precondition(bytes.count <= MemoryLayout<Self>.size)

        var value: Self = 0

        for byte in bytes {
            value <<= 8
            value |= Self(byte)
        }

        self.init(value)
    }
}
