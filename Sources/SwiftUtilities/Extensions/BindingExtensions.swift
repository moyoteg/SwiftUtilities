//
//  Binding.swift
//  Shared
//
//  Created by Moi Gutierrez on 6/17/21.
//

import SwiftUI

public extension Binding {
    
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                    self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
    
    static func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
        Binding<T>(
            get: { lhs.wrappedValue ?? rhs },
            set: { lhs.wrappedValue = $0 }
        )
    }
}

public extension Binding {
    
    func optionalBinding<T>() -> Binding<T>? where T? == Value {
        if let wrappedValue = wrappedValue {
            return Binding<T>(
                get: { wrappedValue },
                set: { self.wrappedValue = $0 }
            )
        } else {
            return nil
        }
    }
}
