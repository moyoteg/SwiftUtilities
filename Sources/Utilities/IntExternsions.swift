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

public extension SignedInteger {

    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<Self>.size)
    }
}

public extension UnsignedInteger {

    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<Self>.size)
    }

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

public protocol IntegerTransform: Sequence where Element: FixedWidthInteger {
    func integer<I: FixedWidthInteger>(endian: Endian) -> I
}

public extension IntegerTransform {
    func integer<I: FixedWidthInteger>(endian: Endian) -> I {
        let f = { (accum: I, next: Element) in accum &<< next.bitWidth | I(next) }
        return endian == .big ? reduce(0, f) : reversed().reduce(0, f)
    }
}
