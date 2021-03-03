//
//  FloatExtensions.swift
//  SwiftUtilities
//
//  Created by Moi Gutierrez on 7/23/20.
//

import Foundation

public extension Float32 {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<Float32>.size)
    }
}
