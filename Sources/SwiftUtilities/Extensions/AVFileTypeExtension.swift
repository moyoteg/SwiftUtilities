//
//  AVFileTypeExtension.swift
//  SwiftUtilities
//
//  Created by Moi Gutierrez on 4/27/22.
//

import Foundation
import AVFoundation

public extension AVFileType {
    /// Fetch and extension for a file from UTI string
    var fileExtension: String {
        guard let type = UTType(self.rawValue),
              let preferredFilenameExtension = type.preferredFilenameExtension
        else {
            return "None"
        }
        return preferredFilenameExtension
    }
}
