//
//  PrivateKeyExtension.swift
//  Utilities
//
//  Created by Moi Gutierrez on 6/5/20.
//

import Foundation
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
