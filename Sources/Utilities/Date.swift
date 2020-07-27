//
//  Date.swift
//  Utilities
//
//  Created by Moi Gutierrez on 7/27/20.
//

import Foundation

public extension Date {
    var millisecondsSince1970: Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0))
    }

    var unsignedMillisecondsSince1970: UInt64 {
        return UInt64((self.timeIntervalSince1970 * 1000.0))
    }
    
    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
    init(milliseconds: UInt64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
