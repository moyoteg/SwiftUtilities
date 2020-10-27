//
//  AnimationExtension.swift
//  Utilities
//
//  Created by Moi Gutierrez on 10/26/20.
//

import SwiftUI

public extension Animation {
    func `repeat`(while expression: Bool, autoreverses: Bool = true) -> Animation {
        if expression {
            return self.repeatForever(autoreverses: autoreverses)
        } else {
            return self
        }
    }
}
