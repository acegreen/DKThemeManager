//
//  UIColor+Utilities.swift
//  DittoKit
//
//  Created by Ace Green on 4/6/21.
//

import UIKit

public extension UIColor {

    // MARK: Convenience Factory Methods

    static func with(hex: UInt32, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: ((CGFloat)((hex & 0xFF0000) >> 16)) / 255.0,
                       green: ((CGFloat)((hex & 0x00FF00) >> 8)) / 255.0,
                       blue: ((CGFloat)((hex & 0x0000FF) >> 0)) / 255.0,
                       alpha: alpha)
    }

    static func with(red: Int, green: Int, blue: Int, alpha: Int = 255) -> UIColor {
        return UIColor(red: min(CGFloat(red) / 255.0, 1.0),
                       green: min(CGFloat(green) / 255.0, 1.0),
                       blue: min(CGFloat(blue) / 255.0, 1.0),
                       alpha: min(CGFloat(alpha) / 255.0, 1.0))
    }

}

public extension UIColor {
    // this function returns a darker shade of the original by lowering HSB brightness
    var darkerShade: UIColor {
        let hsbColor = hsba
        let darkerColor = UIColor(hue: hsbColor.hue,
                                  saturation: hsbColor.saturation,
                                  brightness: hsba.brightness * 0.90,
                                  alpha: hsbColor.alpha)
        return darkerColor
    }

    var hsba: HSBAColor {
        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0
        getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return HSBAColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
}

public struct HSBAColor {
    let hue: CGFloat
    let saturation: CGFloat
    let brightness: CGFloat
    let alpha: CGFloat
}
