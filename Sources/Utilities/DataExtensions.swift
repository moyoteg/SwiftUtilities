//
//  DataExtensions.swift
//  Utilities
//
//  Created by Moi Gutierrez on 6/3/20.
//

import Foundation

public extension Data {
    
    var hexadecimal: String {
        return self.compactMap { String(format: "%02x", $0) }.joined()
    }
}

public extension Data {
    
    var bytes : [UInt8] {
        return [UInt8](self)
    }
}
