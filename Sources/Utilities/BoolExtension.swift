//
//  BoolExtension.swift
//  Utilities
//
//  Created by Moi Gutierrez on 6/5/20.
//

import Foundation

public extension Bool {
    var intValue: Int {
        return self ? 1 : 0
    }
}

public extension Bool {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<Bool>.size)
    }
}
