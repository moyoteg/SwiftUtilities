//
//  IntExternsions.swift
//  Utilities
//
//  Created by Moi Gutierrez on 6/4/20.
//

import Foundation

public extension Int {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<Int>.size)
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
