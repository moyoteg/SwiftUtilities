//
//  CustomOperators.swift
//  SwiftUtilities
//
//  Created by Moi Gutierrez on 6/21/21.
//

import Foundation

infix operator ??=
public func ??=<T>(left: inout T?, right: @autoclosure () -> T) {
    left = left ?? right()
}

infix operator =??
public func =??<T>(left: inout T, right: @autoclosure () -> T?) {
    left = right() ?? left
}

extension Array {
    public mutating func append(_ newElement: Element?) {
        if let element = newElement {
            self.append(element)
        }
    }
}

infix operator !==
public func !==<T>(left: inout T, right: T) where T:Equatable {
    if (left != right) {
        left = right
    }
}
