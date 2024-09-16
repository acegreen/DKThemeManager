//
//  DKDefaultTheme.swift
//  DittoKit
//
//  Created by Ace Green on 4/7/21.
//

import UIKit

// MARK: - Default Theme Fonts

open class DKDefaultThemeFonts: DKThemeFontsProtocol {

    public init() {}

    public static let shared = DKDefaultThemeFonts()

    open var h1: UIFont {
        return UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.semibold)
    }
    open var h2: UIFont {
        return UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.semibold)
    }
    open var h3: UIFont {
        return UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold)
    }
    open var h4: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
    }
    open var body: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
    }
    open var smallBold: UIFont {
        return UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
    }
    open var small: UIFont {
        return UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
    }
    open var micro: UIFont {
        return UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
    }
}

// MARK: - Default Theme Colors

open class DKDefaultThemeColors: DKThemeColorsProtocol {

    public init() {}

    public static let shared = DKDefaultThemeColors()

    open var brand: UIColor {
        return UIColor(named: "cerulean") ?? #colorLiteral(red: 0, green: 0.4705882353, blue: 0.5921568627, alpha: 1)  //#007897
    }

    open var link: UIColor {
        return UIColor(named: "cerulean") ?? #colorLiteral(red: 0, green: 0.4705882353, blue: 0.5921568627, alpha: 1)  //#007897
    }

    open var accent: UIColor {
        return UIColor(named: "sunset_orange") ?? #colorLiteral(red: 0.7960784314, green: 0.3019607843, blue: 0, alpha: 1)  //#CB4D00
    }

    open var neutral1: UIColor {
        return UIColor(named: "charcoal_dark") ?? #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)  //#333333
    }

    open var neutral2: UIColor {
        return UIColor(named: "charcoal_light") ?? #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)  //#666666
    }

    open var neutral3: UIColor {
        return UIColor(named: "neutral_80") ?? #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)  //#CCCCCC
    }

    open var neutral4: UIColor {
        return UIColor(named: "neutral_95") ?? #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)  //#F3F3F3
    }

    open var white: UIColor {
        return  UIColor(named: "white") ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)  //#FFFFFF
    }

    open var feedbackInfo: UIColor {
        return UIColor(named: "cerulean") ?? #colorLiteral(red: 0, green: 0.4705882353, blue: 0.5921568627, alpha: 1)  //#007897
    }

    open var feedbackInfoLight: UIColor {
        return UIColor(named: "cerulean_light") ?? #colorLiteral(red: 0.8, green: 0.9411764706, blue: 0.9764705882, alpha: 1)  //#CCf0F9
    }

    open var feedbackInfoDark: UIColor {
        return UIColor(named: "cerulean_dark") ?? #colorLiteral(red: 0, green: 0.4039215686, blue: 0.5137254902, alpha: 1)  //#006783
    }

    open var feedbackWarning: UIColor {
        return UIColor(named: "dandelion") ?? #colorLiteral(red: 1, green: 0.7960784314, blue: 0.3803921569, alpha: 1)  //#FFCB61
    }

    open var feedbackWarningLight: UIColor {
        return UIColor(named: "dandelion_light") ?? #colorLiteral(red: 1, green: 0.9607843137, blue: 0.8784313725, alpha: 1)  //#FFF5E0
    }

    open var feedbackWarningDark: UIColor {
        return UIColor(named: "medallion") ?? #colorLiteral(red: 0.5098039216, green: 0.3725490196, blue: 0, alpha: 1)  //#825F00
    }

    open var feedbackDanger: UIColor {
        return UIColor(named: "grenadier") ?? #colorLiteral(red: 0.8039215686, green: 0.2352941176, blue: 0.2352941176, alpha: 1)  //#CD3C3C
    }

    open var feedbackDangerLight: UIColor {
        return UIColor(named: "grenadier_light") ?? #colorLiteral(red: 0.9882352941, green: 0.8705882353, blue: 0.8588235294, alpha: 1)  //#FCDEDB
    }

    open var feedbackDangerDark: UIColor {
        return UIColor(named: "grenadier_dark") ?? #colorLiteral(red: 0.6862745098, green: 0.262745098, blue: 0.2117647059, alpha: 1)  //#AF4336
    }

    open var feedbackSuccess: UIColor {
        return UIColor(named: "camarone") ?? #colorLiteral(red: 0.1725490196, green: 0.5254901961, blue: 0.3215686275, alpha: 1)  //#2C8652
    }

    open var feedbackSuccessLight: UIColor {
        return UIColor(named: "camarone_light") ?? #colorLiteral(red: 0.8588235294, green: 0.9529411765, blue: 0.8980392157, alpha: 1)  //#DBF3E5
    }

    open var feedbackSuccessDark: UIColor {
        return UIColor(named: "camarone_dark") ?? #colorLiteral(red: 0.1529411765, green: 0.4549019608, blue: 0.2784313725, alpha: 1)  //#277447
    }

    open var dataViz1: UIColor {
        return UIColor(named: "peacock") ?? #colorLiteral(red: 0, green: 0.5490196078, blue: 0.7254901961, alpha: 1)  //#008CB9
    }

    open var dataViz2: UIColor {
        return UIColor(named: "riviera") ?? #colorLiteral(red: 0.1333333333, green: 0.631372549, blue: 0.568627451, alpha: 1)  //#22A191
    }

    open var dataViz3: UIColor {
        return UIColor(named: "jade") ?? #colorLiteral(red: 0.2156862745, green: 0.6431372549, blue: 0.4, alpha: 1)  //#37A466
    }

    open var dataViz4: UIColor {
        return UIColor(named: "tangelo") ?? #colorLiteral(red: 0.9490196078, green: 0.4235294118, blue: 0.1960784314, alpha: 1)  //#F26C32
    }

    open var dataViz5: UIColor {
        return UIColor(named: "vermillion") ?? #colorLiteral(red: 0.937254902, green: 0.3254901961, blue: 0.2431372549, alpha: 1)  //#EF533E
    }
}
