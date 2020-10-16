//
//  PrivateKeyExtension.swift
//  Utilities
//
//  Created by Moi Gutierrez on 6/5/20.
//

import Foundation
import CryptoKit

extension SecureEnclave.P256.KeyAgreement.PrivateKey: Equatable {
    public static func == (lhs: SecureEnclave.P256.KeyAgreement.PrivateKey,
                           rhs: SecureEnclave.P256.KeyAgreement.PrivateKey) -> Bool {
        return lhs.dataRepresentation == rhs.dataRepresentation
    }
}

// MARK: KeyAgreement

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

// MARK: Signing

extension SecureEnclave.P256.Signing.PrivateKey: Equatable {
    public static func == (lhs: SecureEnclave.P256.Signing.PrivateKey,
                           rhs: SecureEnclave.P256.Signing.PrivateKey) -> Bool {
        lhs.dataRepresentation == rhs.dataRepresentation
    }
}

extension P256.Signing.PrivateKey: Equatable {
    public static func == (lhs: P256.Signing.PrivateKey,
                           rhs: P256.Signing.PrivateKey) -> Bool {
        return lhs.rawRepresentation == rhs.rawRepresentation
    }
}

extension P256.Signing.PrivateKey: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
}

extension P256.Signing.PublicKey: Equatable {
    public static func == (lhs: P256.Signing.PublicKey,
                           rhs: P256.Signing.PublicKey) -> Bool {
        return lhs.rawRepresentation == rhs.rawRepresentation
    }
}

extension P256.KeyAgreement.PublicKey: Codable {

    public enum CodingKeys: CodingKey {
        case key
    }

    public enum VersionError: Error {
        case encoding, decoding
    }

    public init(from decoder: Decoder) throws {
        do {

            let container = try decoder.container(keyedBy: CodingKeys.self)
            let key = try container.decode(P256.KeyAgreement.PublicKey.self, forKey: .key)
            self = key

        } catch {
            print("P256.KeyAgreement.PublicKey: failed to decode: \(error)")
            throw VersionError.decoding
        }

    }

    public func encode(to encoder: Encoder) throws {

        do {

            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(self, forKey: .key)

        } catch {
            print("P256.KeyAgreement.PublicKey: failed to encode: \(error)")
            throw VersionError.encoding
        }
    }
}

extension P256.KeyAgreement.PrivateKey: Codable {

    public enum CodingKeys: CodingKey {
        case key
    }

    public enum VersionError: Error {
        case encoding, decoding
    }

    public init(from decoder: Decoder) throws {
        do {

            let container = try decoder.container(keyedBy: CodingKeys.self)
            let key = try container.decode(P256.KeyAgreement.PrivateKey.self, forKey: .key)
            self = key

        } catch {
            print("P256.KeyAgreement.PrivateKey: failed to decode: \(error)")
            throw VersionError.decoding
        }

    }

    public func encode(to encoder: Encoder) throws {

        do {

            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(self, forKey: .key)

        } catch {
            print("P256.KeyAgreement.PrivateKey: failed to encode: \(error)")
            throw VersionError.encoding
        }
    }
}

extension P256.KeyAgreement.PrivateKey: CustomStringConvertible {
    public var description: String {
        return "\(rawRepresentation)"
    }
}
