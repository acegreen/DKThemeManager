//
//  UIColor+Extensions.swift
//  DittoKit
//
//  Created by Ace Green on 4/6/21.
//

import UIKit

public extension UIColor {

    convenience init?(hex: String) {
        let red, green, blue, alpha: CGFloat
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
            if hexColor.count == 8 {
                if scanner.scanHexInt64(&hexNumber) {
                    red = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    green = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    blue = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    alpha = CGFloat(hexNumber & 0x000000ff) / 255
                    self.init(red: red, green: green, blue: blue, alpha: alpha)
                    return
                }
            } else if hexColor.count == 6 {
                if scanner.scanHexInt64(&hexNumber) {
                    red = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    green = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    blue = CGFloat(hexNumber & 0x0000ff) / 255
                    self.init(red: red, green: green, blue: blue, alpha: 1.0)
                    return
                }
            }
        }
        return nil
    }

    func colorWithBrightness(_ newBrightness: CGFloat) -> UIColor {
        // swiftlint:disable identifier_name
        var H: CGFloat = 0, S: CGFloat = 0, B: CGFloat = 0, A: CGFloat = 0
        // swiftlint:enable identifier_name

        if getHue(&H, saturation: &S, brightness: &B, alpha: &A) {
            B += (newBrightness - 1.0)
            B = max(min(B, 1.0), 0.0)

            return UIColor(hue: H, saturation: S, brightness: B, alpha: A)
        }
        return self
    }
}
