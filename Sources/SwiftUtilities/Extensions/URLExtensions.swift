//
//  URLExtensions.swift
//  SwiftUtilities
//
//  Created by Moi Gutierrez on 10/20/20.
//

import Foundation

public extension URL {
    var attributes: [FileAttributeKey : Any]? {
        do {
            return try FileManager.default.attributesOfItem(atPath: path)
        } catch let error as NSError {
            print("FileAttribute error: \(error)")
        }
        return nil
    }

    var fileSize: UInt64 {
        return attributes?[.size] as? UInt64 ?? UInt64(0)
    }

    var fileSizeString: String {
        return ByteCountFormatter.string(fromByteCount: Int64(fileSize), countStyle: .file)
    }

    var creationDate: Date? {
        return attributes?[.creationDate] as? Date
    }
}

public extension URL {
    subscript(queryParam:String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParam })?.value
    }
    
    func readWithPermission() -> Result<String,Error> {
        let accessing = self.startAccessingSecurityScopedResource()
        defer {
            if accessing {
                self.stopAccessingSecurityScopedResource()
            }
        }
        return Result { try String(contentsOf: self) }
    }
}

