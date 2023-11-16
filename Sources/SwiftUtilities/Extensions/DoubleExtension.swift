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

public extension Double {

  // Formatting double value to k and M
  // 1000 = 1k
  // 1100 = 1.1k
  // 15000 = 15k
  // 115000 = 115k
  // 1000000 = 1m
    var readerFriendly: String {
        let thousandNum = self/1000
        let millionNum = self/1000000
        if self >= 1000 && self < 1000000{
            if(floor(thousandNum) == thousandNum){
                return ("\(Int(thousandNum))k").replacingOccurrences(of: ".0", with: "")
            }
            return("\(thousandNum.roundTo(places: 1))k").replacingOccurrences(of: ".0", with: "")
        }
        if self > 1000000{
            if(floor(millionNum) == millionNum){
                return("\(Int(thousandNum))k").replacingOccurrences(of: ".0", with: "")
            }
            return ("\(millionNum.roundTo(places: 1))M").replacingOccurrences(of: ".0", with: "")
        }
        else{
            if(floor(self) == self){
                return ("\(Int(self))")
            }
            return ("\(self)")
        }
    }

    /// Returns rounded value for passed places
    ///
    /// - parameter places: Pass number of digit for rounded value off after decimal
    ///
    /// - returns: Returns rounded value with passed places
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

public extension Double {
    func toRadians() -> Double {
        return self * .pi / 180
    }
}
