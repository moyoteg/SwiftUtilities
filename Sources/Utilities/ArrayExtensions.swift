//
//  ArrayExtensions.swift
//  Created by Moi Gutierrez on 1/21/20.
//

import Foundation

public extension Array {
    
    subscript (safe index: Int) -> Element? {
        get {
            return index < count && index >= 0 ? self[index] : nil
        }
        set {
            if let element = newValue, index < count, index >= 0 {
                self[index] = element
            }
        }
    }
}

public extension Array where Element == UInt8 {
    var data : Data{
        return Data(self)
    }
}
