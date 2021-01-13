//
//  UIDeviceExtension.swift
//  Utilities
//
//  Created by Moi Gutierrez on 10/15/20.
//

import Foundation
import UIKit

import DeviceKit

public extension UIDevice {
    
    static var model: DeviceKit.Device {
        return Device.current
    }
    
    /// pares the deveice name as the standard name
    static var modelName: String {
        return "\(UIDevice.model)"
    }
    
}
