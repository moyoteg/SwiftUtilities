//
//  Biometric.swift
//  SwiftUtilities
//
//  Created by Moi Gutierrez on 8/18/22.
//

import Foundation
import LocalAuthentication

public enum Biometric {
#if !os(tvOS) && !os(watchOS)
    public static let type = LAContext().biometryType
#endif
}

