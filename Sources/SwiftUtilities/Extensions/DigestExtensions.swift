//
//  DigestExtensions.swift
//  SwiftUtilities
//
//  Created by Moi Gutierrez on 1/26/22.
//

import Foundation
import Foundation
import CryptoKit

// CryptoKit.Digest utils
public extension Digest {
    var bytes: [UInt8] { Array(makeIterator()) }
    var data: Data { Data(bytes) }

    var asHexString: String {
        bytes.map { String(format: "%02X", $0) }.joined()
    }
}
