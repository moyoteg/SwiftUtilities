//
//  CustomOperator.swift
//  Utilities
//
//  Created by Moi Gutierrez on 1/13/21.
//

import Foundation

import SwiftUI

public prefix func ! (value: Binding<Bool>) -> Binding<Bool> {
    Binding<Bool>(
        get: { !value.wrappedValue },
        set: { value.wrappedValue = !$0 }
    )
}
