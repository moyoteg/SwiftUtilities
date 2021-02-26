//
//  ColorExtensions.swift
//  Utilities
//
//  Created by Moi Gutierrez on 2/25/21.
//

import SwiftUI

extension Color: Identifiable {
    public var id: String {
        self.description
    }
}
