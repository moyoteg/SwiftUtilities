//
//  UIFontExtension.swift
//  Shared
//
//  Created by Moi Gutierrez on 1/18/21.
//

#if !os(macOS)
import UIKit

// This extension is taken from this SO answer https://stackoverflow.com/a/36871032/5508175
public extension UIFont {
    static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) -> Bool {

        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension) else {
            fatalError("UIFont: Couldn't find font \(fontName)")
        }

        guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL) else {
            fatalError("UIFont: Couldn't load data from the font \(fontName)")
        }

        guard let font = CGFont(fontDataProvider) else {
            fatalError("UIFont: Couldn't create font from data")
        }

        var error: Unmanaged<CFError>?
        let success = CTFontManagerRegisterGraphicsFont(font, &error)
        guard success else {
            print("UIFont: Error registering font: maybe it was already registered.")
            return false
        }

        return true
    }
}
#endif
