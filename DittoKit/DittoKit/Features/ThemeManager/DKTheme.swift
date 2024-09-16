//
//  DKTheme.swift
//  DittoKit
//
//  Created by Ace Green on 4/7/21.
//

import UIKit

// MARK: - DKThemeColorsProtocol, DKThemeFontsProtocol

public protocol DKThemeFontsProtocol {

    var h1: UIFont { get }
    var h2: UIFont { get }
    var h3: UIFont { get }
    var h4: UIFont { get }
    var body: UIFont { get }
    var smallBold: UIFont { get }
    var small: UIFont { get }
    var micro: UIFont { get }
}

public protocol DKThemeColorsProtocol {

    var brand: UIColor { get }
    var link: UIColor { get }
    var accent: UIColor { get }

    var neutral1: UIColor { get }
    var neutral2: UIColor { get }
    var neutral3: UIColor { get }
    var neutral4: UIColor { get }
    var white: UIColor { get }

    var feedbackInfo: UIColor { get }
    var feedbackInfoLight: UIColor { get }
    var feedbackInfoDark: UIColor { get }

    var feedbackWarning: UIColor { get }
    var feedbackWarningLight: UIColor { get }
    var feedbackWarningDark: UIColor { get }

    var feedbackDanger: UIColor { get }
    var feedbackDangerLight: UIColor { get }
    var feedbackDangerDark: UIColor { get }

    var feedbackSuccess: UIColor { get }
    var feedbackSuccessLight: UIColor { get }
    var feedbackSuccessDark: UIColor { get }

    var dataViz1: UIColor { get }
    var dataViz2: UIColor { get }
    var dataViz3: UIColor { get }
    var dataViz4: UIColor { get }
    var dataViz5: UIColor { get }
}

// MARK: - DKTheme

public class DKTheme {

    /// Fonts
    public var fonts: DKThemeFontsProtocol

    /// Colors
    public var colors: DKThemeColorsProtocol

    public init(fonts: DKThemeFontsProtocol,
                colors: DKThemeColorsProtocol) {
        self.fonts = fonts
        self.colors = colors
    }

    public class H1Primary: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.h1
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.neutral1
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 32
        }
    }

    public class H1Link: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.h1
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.link
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 32
        }
    }

    public class H1Rev: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.h1
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var backgroundColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var lineHeight: CGFloat {
            return 32
        }
    }

    public class H2Primary: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.h2
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.neutral1
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 32
        }
    }

    public class H2Link: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.h2
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.link
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 32
        }
    }

    public class H2Rev: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.h2
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var backgroundColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var lineHeight: CGFloat {
            return 32
        }
    }

    public class H3Primary: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.h3
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.neutral1
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 24
        }
    }

    public class H3Secondary: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.h3
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.neutral2
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 24
        }
    }

    public class H3Link: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.h3
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.link
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 24
        }
    }

    public class H3Rev: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.h3
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var backgroundColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var lineHeight: CGFloat {
            return 24
        }
    }

    public class H3Warning: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.h3
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.feedbackWarningDark
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 24
        }
    }

    public class H3Danger: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.h3
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.feedbackDangerDark
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 24
        }
    }

    public class H3Success: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.h3
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.feedbackSuccessDark
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 24
        }
    }

    public class H4Primary: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.h3
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.neutral1
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 24
        }
    }

    public class H4Button: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.h4
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 24
        }
    }

    public class H4Secondary: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.h4
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.neutral2
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 24
        }
    }

    public class H4Link: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.h4
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.link
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 24
        }
    }

    public class H4Rev: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.h4
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var backgroundColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var lineHeight: CGFloat {
            return 24
        }
    }

    public class H4Warning: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.h4
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.feedbackWarningDark
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 24
        }
    }

    public class H4Danger: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.h4
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.feedbackDangerDark
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 24
        }
    }

    public class H4Success: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.h4
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.feedbackSuccessDark
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 24
        }
    }

    public class BodyPrimary: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.body
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.neutral1
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 24
        }
    }

    public class BodySecondary: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.body
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.neutral2
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 24
        }
    }

    public class BodyLink: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.body
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.link
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 24
        }
    }

    public class BodyRev: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.body
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var backgroundColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var lineHeight: CGFloat {
            return 24
        }
    }

    public class BodyWarning: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.body
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.feedbackWarningDark
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 24
        }
    }

    public class BodyDanger: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.body
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.feedbackDangerDark
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 24
        }
    }

    public class BodySuccess: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.body
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.feedbackSuccessDark
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 24
        }
    }

    public class SmallBoldPrimary: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.smallBold
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.neutral1
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 20
        }
    }

    public class SmallBoldButton: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.smallBold
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 20
        }
    }

    public class SmallBoldSecondary: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.smallBold
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.neutral2
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 20
        }
    }

    public class SmallBoldLink: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.smallBold
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.link
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 20
        }
    }

    public class SmallBoldRev: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.smallBold
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var backgroundColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var lineHeight: CGFloat {
            return 20
        }
    }

    public class SmallBoldWarnings: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.smallBold
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.feedbackWarningDark
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 20
        }
    }

    public class SmallBoldDanger: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.smallBold
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.feedbackDangerDark
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 20
        }
    }

    public class SmallBoldSuccess: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.smallBold
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.feedbackSuccessDark
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 20
        }
    }

    public class SmallPrimary: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.small
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.neutral1
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 20
        }
    }

    public class SmallSecondary: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.small
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.neutral2
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 20
        }
    }

    public class SmallLink: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.small
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.link
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 20
        }
    }

    public class SmallRev: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.small
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var backgroundColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var lineHeight: CGFloat {
            return 20
        }
    }

    public class SmallWarning: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.small
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.feedbackWarningDark
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 20
        }
    }

    public class SmallDanger: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.small
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.feedbackDangerDark
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 20
        }
    }

    public class SmallSuccess: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.small
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.feedbackSuccessDark
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 20
        }
    }

    public class MicroPrimary: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.micro
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.neutral1
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 16
        }
    }

    public class MicroSecondary: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.micro
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.neutral2
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 16
        }
    }

    public class MicroLink: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.micro
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.link
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var lineHeight: CGFloat {
            return 16
        }
    }

    public class MicroRev: DKLabel {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.micro
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var backgroundColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var lineHeight: CGFloat {
            return 16
        }
    }

    public class PrimaryButton: DKButton {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.h4
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var backgroundColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var borderColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var tappedTextColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var tappedBackgroundColor: UIColor {
            return DKThemeManager.shared.current.colors.link
        }
        public var tappedBorderColor: UIColor {
            return DKThemeManager.shared.current.colors.link
        }
        public var height: CGFloat {
            return 48
        }
        public var cornerRadius: CGFloat {
            return 24
        }
        public var contentInsets: UIEdgeInsets {
            return UIEdgeInsets(top: 2, left: 24, bottom: 2, right: 24)
        }
    }

    public class PrimaryAltButton: DKButton {
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.h4
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }

        public var backgroundColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var borderColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var tappedTextColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var tappedBackgroundColor: UIColor {
            return DKThemeManager.shared.current.colors.white.withAlphaComponent(0.08)
        }
        public var tappedBorderColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var height: CGFloat {
            return 48
        }
        public var cornerRadius: CGFloat {
            return 24
        }
        public var contentInsets: UIEdgeInsets {
            return UIEdgeInsets(top: 2, left: 24, bottom: 2, right: 24)
        }
    }

    public class SecondaryButton: DKButton {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.h4
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var backgroundColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var borderColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var tappedTextColor: UIColor {
            return DKThemeManager.shared.current.colors.link
        }
        public var tappedBackgroundColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var tappedBorderColor: UIColor {
            return DKThemeManager.shared.current.colors.link
        }
        public var height: CGFloat {
            return 48
        }
        public var cornerRadius: CGFloat {
            return 24
        }
        public var contentInsets: UIEdgeInsets {
            return UIEdgeInsets(top: 2, left: 24, bottom: 2, right: 24)
        }
    }

    public class DestructiveButton: DKButton {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.h4
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.feedbackDangerDark
        }
        public var backgroundColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var borderColor: UIColor {
            return DKThemeManager.shared.current.colors.feedbackDangerDark
        }
        public var tappedTextColor: UIColor {
            return DKThemeManager.shared.current.colors.feedbackDangerDark
        }
        public var tappedBackgroundColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var tappedBorderColor: UIColor {
            return DKThemeManager.shared.current.colors.feedbackDangerDark
        }
        public var height: CGFloat {
            return 48
        }
        public var cornerRadius: CGFloat {
            return 24
        }
        public var contentInsets: UIEdgeInsets {
            return UIEdgeInsets(top: 2, left: 24, bottom: 2, right: 24)
        }
    }

    public class SmallPrimaryButton: DKButton {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.small
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var backgroundColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var borderColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var tappedTextColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var tappedBackgroundColor: UIColor {
            return DKThemeManager.shared.current.colors.link
        }
        public var tappedBorderColor: UIColor {
            return DKThemeManager.shared.current.colors.link
        }
        public var height: CGFloat {
            return 28
        }
        public var cornerRadius: CGFloat {
            return 14
        }
        public var contentInsets: UIEdgeInsets {
            return UIEdgeInsets(top: 2, left: 16, bottom: 2, right: 16)
        }
    }

    public class SmallSecondaryButton: DKButton {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.small
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var backgroundColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var borderColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var tappedTextColor: UIColor {
            return DKThemeManager.shared.current.colors.link
        }
        public var tappedBackgroundColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var tappedBorderColor: UIColor {
            return DKThemeManager.shared.current.colors.link
        }
        public var height: CGFloat {
            return 28
        }
        public var cornerRadius: CGFloat {
            return 14
        }
        public var contentInsets: UIEdgeInsets {
            return UIEdgeInsets(top: 2, left: 16, bottom: 2, right: 16)
        }
    }

    public class SmallDestructiveButton: DKButton {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.small
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.feedbackDangerDark
        }
        public var backgroundColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var borderColor: UIColor {
            return DKThemeManager.shared.current.colors.feedbackDangerDark
        }
        public var tappedTextColor: UIColor {
            return DKThemeManager.shared.current.colors.feedbackDangerDark
        }
        public var tappedBackgroundColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var tappedBorderColor: UIColor {
            return DKThemeManager.shared.current.colors.feedbackDangerDark
        }
        public var height: CGFloat {
            return 28
        }
        public var cornerRadius: CGFloat {
            return 14
        }
        public var contentInsets: UIEdgeInsets {
            return UIEdgeInsets(top: 2, left: 16, bottom: 2, right: 16)
        }
    }

    // AG: PrimaryTextButton isn't part of the MDS and is only to support Megazord requirements

    public class PrimaryTextButton: DKButton {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.small
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var backgroundColor: UIColor {
            return .clear
        }
        public var borderColor: UIColor {
            return .clear
        }
        public var tappedTextColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var tappedBackgroundColor: UIColor {
            return .clear
        }
        public var tappedBorderColor: UIColor {
            return .clear
        }
        public var height: CGFloat {
            return 28
        }
        public var cornerRadius: CGFloat {
            return 0
        }
        public var contentInsets: UIEdgeInsets {
            return .zero
        }
    }

    public class DefaultRadioButton: DKToggleButton {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.body
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.neutral1
        }
        public var icon: UIImage {
            return DKRDSIcons.radioUnselected.image?.tintedImage(with: DKThemeManager.shared.current.colors.neutral2) ?? UIImage()
        }
        public var iconSelected: UIImage {
            return DKRDSIcons.radioSelected.image?.tintedImage(with: DKThemeManager.shared.current.colors.brand) ?? UIImage()
        }
    }

    public class DefaultCheckboxButton: DKToggleButton {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.body
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.neutral1
        }
        public var icon: UIImage {
            return DKRDSIcons.checkboxUnselected.image?.tintedImage(with: DKThemeManager.shared.current.colors.neutral2) ?? UIImage()
        }
        public var iconSelected: UIImage {
            return DKRDSIcons.checkboxSelected.image?.tintedImage(with: DKThemeManager.shared.current.colors.brand) ?? UIImage()
        }
    }

    public class DefaultTextField: DKTextField {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.body
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.neutral1
        }
        public var tintColor: UIColor {
            return DKThemeManager.shared.current.colors.link
        }
        public var backgroundColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var contentInsets: UIEdgeInsets? {
            return UIEdgeInsets(top: 2, left: 18, bottom: 2, right: 18)
        }
        public var height: CGFloat {
            return 48
        }
    }

    public class DefaultTextFormField: DKTextFormField {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.body
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.neutral1
        }
        public var tintColor: UIColor {
            return DKThemeManager.shared.current.colors.link
        }
        public var backgroundColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var contentInsets: UIEdgeInsets? {
            return UIEdgeInsets(top: 2, left: 18, bottom: 2, right: 18)
        }
        public var focusedColor: UIColor {
            return DKThemeManager.shared.current.colors.link
        }
        public var unfocusedColor: UIColor {
            return DKThemeManager.shared.current.colors.neutral2
        }
        public var errorColor: UIColor {
            return DKThemeManager.shared.current.colors.feedbackDangerDark
        }
        public var disabledColor: UIColor {
            return DKThemeManager.shared.current.colors.neutral4
        }
        public var height: CGFloat {
            return 48
        }
    }

    public class DefaultNavigationBar: DKNavigationBar {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.h4
        }
        public var largeFont: UIFont {
            return DKThemeManager.shared.current.fonts.h1
        }
        public var titleColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var tintColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var backgroundColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var backButtonStyleColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var defaultButtonStyleColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var doneButtonStyleColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var prefersLargeTitles: Bool {
            return false
        }
    }

    // AG: ReverseNavigationBar isn't part of MDS but makes sense as an addition

    public class ReverseNavigationBar: DKNavigationBar {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.h4
        }
        public var largeFont: UIFont {
            return DKThemeManager.shared.current.fonts.h1
        }
        public var titleColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var tintColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var backgroundColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var backButtonStyleColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var defaultButtonStyleColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var doneButtonStyleColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var prefersLargeTitles: Bool {
            return false
        }
    }

    // AG: BlackTintedNavigationBar isn't part of the MDS and is only to support Megazord requirements

    public class BlackTintedNavigationBar: DKNavigationBar {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.h4
        }
        public var largeFont: UIFont {
            return DKThemeManager.shared.current.fonts.h1
        }
        public var titleColor: UIColor {
            return DKThemeManager.shared.current.colors.neutral1
        }
        public var tintColor: UIColor {
            return DKThemeManager.shared.current.colors.neutral1
        }
        public var backgroundColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var backButtonStyleColor: UIColor {
            return DKThemeManager.shared.current.colors.neutral1
        }
        public var defaultButtonStyleColor: UIColor {
            return DKThemeManager.shared.current.colors.neutral1
        }
        public var doneButtonStyleColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var prefersLargeTitles: Bool {
            return true
        }
    }

    public class DefaultTabBar: DKTabBar {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.small
        }
        public var titleColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var selectedTitleColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var backgroundColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
    }

    // AG: ReverseTabBar not part of MDS but makes sense as an addition

    public class ReverseTabBar: DKTabBar {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.small
        }
        public var titleColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var selectedTitleColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var backgroundColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
    }

    // AG: BlackTintedDefaultTabBar isn't part of the MDS and is only to support Megazord requirements

    public class BlackTintedDefaultTabBar: DKTabBar {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.small
        }
        public var titleColor: UIColor {
            return DKThemeManager.shared.current.colors.neutral2
        }
        public var selectedTitleColor: UIColor {
            return DKThemeManager.shared.current.colors.neutral1
        }
        public var backgroundColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
    }

    public class DefaultSegmentedControl: DKSegmentedControl {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.small
        }
        public var selectedFont: UIFont {
            return DKThemeManager.shared.current.fonts.h4
        }
        public var borderColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var selectedTextColor: UIColor {
            return DKThemeManager.shared.current.colors.white
        }
        public var selectionStyle: DKSegmentedControlSelectionStyle {
            return .background
        }
        public var equalWidthSegments: Bool {
            return true
        }
        public var height: CGFloat {
            return 32
        }
    }

    public class UnderlinedSegmentedControl: DKSegmentedControl {
        public init() {}
        public var font: UIFont {
            return DKThemeManager.shared.current.fonts.small
        }
        public var selectedFont: UIFont {
            return DKThemeManager.shared.current.fonts.h4
        }
        public var borderColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
        public var textColor: UIColor {
            return DKThemeManager.shared.current.colors.neutral2
        }
        public var selectedTextColor: UIColor {
            return DKThemeManager.shared.current.colors.neutral1
        }
        public var selectionStyle: DKSegmentedControlSelectionStyle {
            return .underlineBar(color: DKThemeManager.shared.current.colors.link)
        }
        public var equalWidthSegments: Bool {
            return true
        }
        public var height: CGFloat {
            return 32
        }
    }

    // AG: DefaultSwitch isn't part of MDS but should be supported in Ditto DS

    public class DefaultSwitch: DKSwitch {
        public init() {}
        public var tintColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
    }

    // Additional Styles

    public class DefaultImage: DKImage {
        public init() {}
        public var tintColor: UIColor {
            return DKThemeManager.shared.current.colors.brand
        }
    }

    public class CustomImage: DKImage {
        private init() {}
        public var tintColor = UIColor.clear
        public init(tintColor: UIColor) {
            self.tintColor = tintColor
        }
    }
}
