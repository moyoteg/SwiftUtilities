//
//  StringExtensions.swift
//  SwiftUtilities
//
//  Created by Moi Gutierrez on 6/5/20.
//

import Foundation
import SwiftUI

public extension String {
    
    func acronymOrFormattedString() -> String {
        let prepositionsAndConjunctions = ["and", "of"]
        let words = self.components(separatedBy: " ")
        
        // Filter out specified prepositions and conjunctions, and check if multiple significant words remain.
        let significantWords = words.filter { !prepositionsAndConjunctions.contains($0.lowercased()) }
        guard significantWords.count > 1 else { return self.capitalizingFirstLetter() }
        
        // Form the acronym or formatted string depending on the number of significant words.
        let acronym = significantWords.dropLast().reduce("") { partialResult, word in
            partialResult + (word.first?.uppercased() ?? "")
        }
        
        let lastWordFormatted = significantWords.last?.withOnlyFirstLetterUppercased() ?? ""
        
        return acronym + (acronym.isEmpty ? "" : " ") + lastWordFormatted
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    func withOnlyFirstLetterUppercased() -> String {
        return prefix(1).uppercased() + dropFirst().lowercased()
    }
}

public extension String {
   
    func convertToValidFileName() -> String {
       let invalidFileNameCharactersRegex = "[^a-zA-Z0-9_]+"
       let fullRange = startIndex..<endIndex
       let validName = replacingOccurrences(of: invalidFileNameCharactersRegex,
                                          with: "-",
                                       options: .regularExpression,
                                         range: fullRange)
       return validName
   }
}

public extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
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

public extension String {
    var bool: Bool? {
        switch self.lowercased() {
        case "true", "t", "yes", "y", "1": return true
        case "false", "f", "no", "n", "0": return false
        default:return nil
        }
    }
}

public extension String {
    var capitalizedFirstLetter: String {
        guard !isEmpty else { return self }
        return prefix(1).capitalized + dropFirst()
    }
}

extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}

#if !os(macOS)
public extension String {
    var isValidURL: Bool {
        if let url = NSURL(string: self) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
        return false
    }
}
#endif

public extension String {
    
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}

public extension String {
    func removingLeadingWhitespace() -> String {
        return self.replacingOccurrences(of: "^\\s+", with: "", options: .regularExpression)
    }
}
