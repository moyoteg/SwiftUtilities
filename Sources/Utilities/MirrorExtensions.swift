//
//  File.swift
//  
//
//  Created by Moi Gutierrez on 5/14/20.
//

import Foundation

extension Mirror: Identifiable {
    public var id: String {
        return "\(self.description)"
    }
}
