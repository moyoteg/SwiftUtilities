//
//  CollectionExtensions.swift
//  Created by Moi Gutierrez on 4/17/20.
//

import Foundation

public extension Collection where Indices.Iterator.Element == Index {

    subscript(safe index: Index) -> Iterator.Element? {

     return (startIndex <= index && index < endIndex) ? self[index] : nil
   }
}
