//
//  PrivateKeyExtension.swift
//  Utilities
//
//  Created by Moi Gutierrez on 6/5/20.
//

import Foundation
import CryptoKit

extension SecureEnclave.P256.Signing.PrivateKey: Equatable {
    public static func == (lhs: SecureEnclave.P256.Signing.PrivateKey,
                           rhs: SecureEnclave.P256.Signing.PrivateKey) -> Bool {
        lhs.dataRepresentation == rhs.dataRepresentation
    }
}

extension SecureEnclave.P256.KeyAgreement.PrivateKey: Equatable {
    public static func == (lhs: SecureEnclave.P256.KeyAgreement.PrivateKey,
                           rhs: SecureEnclave.P256.KeyAgreement.PrivateKey) -> Bool {
        return lhs.dataRepresentation == rhs.dataRepresentation
    }
}

extension P256.KeyAgreement.PrivateKey: Equatable {
    public static func == (lhs: P256.KeyAgreement.PrivateKey,
                           rhs: P256.KeyAgreement.PrivateKey) -> Bool {
        return lhs.rawRepresentation == rhs.rawRepresentation
    }
}

extension P256.KeyAgreement.PublicKey: Equatable {
    public static func == (lhs: P256.KeyAgreement.PublicKey,
                           rhs: P256.KeyAgreement.PublicKey) -> Bool {
        return lhs.rawRepresentation == rhs.rawRepresentation
    }
}

public extension SecureEnclave.P256.KeyAgreement.PrivateKey {
    
    var PEMFormatString: String {
        let keyBase64 = self.dataRepresentation.base64EncodedString(options: [.lineLength64Characters])
        var pemString = ""
        pemString.append("-----BEGIN PRIVATE KEY-----\n")
        pemString.append(keyBase64)
        pemString.append("\n")
        pemString.append("-----END PRIVATE KEY-----\n")
        return pemString
    }
}

public extension P256.KeyAgreement.PrivateKey {
    
    var PEMFormatString: String {
        let keyBase64 = self.rawRepresentation.base64EncodedString(options: [.lineLength64Characters])
        var pemString = ""
        let components:[String] = keyBase64.components(separatedBy: "\r\n")
        pemString.append("-----BEGIN PUBLIC KEY-----\n")
        components.forEach { (string) in
            pemString.append(string)
            pemString.append("\n")
        }
        pemString.append("-----END PUBLIC KEY-----\n")
        return pemString
    }
}

public extension P256.KeyAgreement.PublicKey {
    
    var PEMFormatString: String {
        let keyBase64 = self.rawRepresentation.base64EncodedString(options: [.lineLength64Characters])
        var pemString = ""
        let components:[String] = keyBase64.components(separatedBy: "\r\n")
        pemString.append("-----BEGIN PUBLIC KEY-----\n")
        components.forEach { (string) in
            pemString.append(string)
            pemString.append("\n")
        }
        pemString.append("-----END PUBLIC KEY-----\n")
        return pemString
    }
}
