//
//  StringExtensions.swift
//  Utilities
//
//  Created by Moi Gutierrez on 6/5/20.
//

import Foundation

public extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

public extension String {

    /// Create `Data` from hexadecimal string representation
    ///
    /// This creates a `Data` object from hex string. Note, if the string has any spaces or non-hex characters (e.g. starts with '<' and with a '>'), those are ignored and only hex characters are processed.
    ///
    /// - returns: Data represented by this hexadecimal string.

    var asHexadecimalData: Data? {
        var data = Data(capacity: self.count / 2)

        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        
        regex.enumerateMatches(in: self, range: NSRange(startIndex..., in: self)) { match, _, _ in
            
            let byteString = (self as NSString).substring(with: match!.range)
            
            let num = UInt8(byteString, radix: 16)!
            
            data.append(num)
        }

        guard data.count > 0 else { return nil }

        return data
    }

    
    /// Create `String` representation of `Data` created from hexadecimal string representation
    ///
    /// This takes a hexadecimal representation and creates a String object from that. Note, if the string has any spaces, those are removed. Also if the string started with a `<` or ended with a `>`, those are removed, too.
    ///
    /// For example,
    ///
    ///     String(hexadecimal: "<666f6f>")
    ///
    /// is
    ///
    ///     Optional("foo")
    ///
    /// - returns: `String` represented by this hexadecimal string.

    init?(hexadecimal string: String, encoding: String.Encoding = .utf8) {
        guard let data = string.asHexadecimalData else {
            return nil
        }

        self.init(data: data, encoding: encoding)
    }

    /// Create hexadecimal string representation of `String` object.
    ///
    /// For example,
    ///
    ///     "foo".hexadecimalString()
    ///
    /// is
    ///
    ///     Optional("666f6f")
    ///
    /// - parameter encoding: The `String.Encoding` that indicates how the string should be converted to `Data` before performing the hexadecimal conversion.
    ///
    /// - returns: `String` representation of this String object.

    func asHexadecimalString(encoding: String.Encoding = .utf8) -> String? {
        return data(using: encoding)?
            .asHexadecimalString
    }
}

import CryptoKit

public extension SecureEnclave.P256.KeyAgreement.PrivateKey {
    
    func pemFormatString() -> String {
        let keyBase64 = self.publicKey.rawRepresentation.base64EncodedString(options: [.lineLength64Characters])
        var pemString = ""
        let a:[String] = keyBase64.components(separatedBy: "\r\n")
        pemString.append("-----BEGIN PUBLIC KEY-----\n")
        a.forEach { (string) in
            pemString.append(string)
            pemString.append("\n")
        }
        pemString.append("-----END PUBLIC KEY-----\n\n")
        return pemString
    }
    
    func pemFormatString(private key: SecureEnclave.P256.KeyAgreement.PrivateKey) -> String {
        let keyBase64 = key.dataRepresentation.base64EncodedString(options: [.lineLength64Characters])
        var pemString = ""
        pemString.append("-----BEGIN PRIVATE KEY-----")
        pemString.append(keyBase64)
        pemString.append("-----END PRIVATE KEY-----")
        return pemString
    }
}
