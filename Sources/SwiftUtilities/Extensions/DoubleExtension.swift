//
//  DoubleExtension.swift
//  SwiftUtilities
//
//  Created by Moi Gutierrez on 2/1/22.
//

import Foundation

public extension Double {

    func toInt() -> Int? {
        let roundedValue = rounded(.toNearestOrEven)
        return Int(exactly: roundedValue)
    }

}
