//
//  EncodableExtensions.swift
//  LoginUI
//
//  Created by Moi Gutierrez on 1/15/20.
//  Copyright © 2020 Moi Gutierrez. All rights reserved.
//

import Foundation

public extension Encodable {

    /// Converting object to postable dictionary
    func toDictionary(_ encoder: JSONEncoder = JSONEncoder()) throws -> [String: Any] {
        let data = try encoder.encode(self)
        let object = try JSONSerialization.jsonObject(with: data)
        guard let json = object as? [String: Any] else {
            let context = DecodingError.Context(codingPath: [], debugDescription: "Deserialized object is not a dictionary")
            throw DecodingError.typeMismatch(type(of: object), context)
        }
        return json
    }
}
