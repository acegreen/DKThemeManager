//
//  DKThemeStyle.swift
//  DittoKit
//
//  Created by Ace Green on 4/7/21.
//

import UIKit

// MARK: - DKLabel

public protocol DKLabel {
    var font: UIFont { get }
    var textColor: UIColor { get }
    var backgroundColor: UIColor { get }

    func getStringAttributes(currentAlignment: NSTextAlignment, lineBreakMode: NSLineBreakMode) -> [NSAttributedString.Key: Any]
}

public extension DKLabel {

    func getStringAttributes(currentAlignment: NSTextAlignment = .left,
                             lineBreakMode: NSLineBreakMode = .byWordWrapping) -> [NSAttributedString.Key: Any] {
        let style = NSMutableParagraphStyle()
        style.alignment = currentAlignment
        style.lineBreakMode = lineBreakMode
        return [NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: textColor,
                NSAttributedString.Key.paragraphStyle: style]
    }
}

// MARK: - DKButton

public protocol DKButton {
    var font: UIFont { get }
    var textColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var borderColor: UIColor { get }
    var tappedTextColor: UIColor { get }
    var tappedBackgroundColor: UIColor { get }
    var tappedBorderColor: UIColor { get }
    var height: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var contentInsets: UIEdgeInsets { get }

    func getStringAttributes() -> [NSAttributedString.Key: Any]
    func getSelectedStringAttributes() -> [NSAttributedString.Key: Any]
}

public extension DKButton {

    func getStringAttributes() -> [NSAttributedString.Key: Any] {
        let style = NSMutableParagraphStyle()
        style.minimumLineHeight = height
        return [NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: textColor,
                NSAttributedString.Key.paragraphStyle: style]
    }

    func getSelectedStringAttributes() -> [NSAttributedString.Key: Any] {
        let style = NSMutableParagraphStyle()
        style.minimumLineHeight = height
        return [NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: tappedTextColor,
                NSAttributedString.Key.paragraphStyle: style]
    }
}

public protocol DKToggleButton {
    var font: UIFont { get }
    var textColor: UIColor { get }
    var icon: UIImage { get }
    var iconSelected: UIImage { get }
}

// MARK: - DKTextField

public protocol DKTextField {
    var font: UIFont { get }
    var textColor: UIColor { get }
    var tintColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var contentInsets: UIEdgeInsets? { get }
    var height: CGFloat { get }

    func getStringAttributes(currentAlignment: NSTextAlignment, lineBreakMode: NSLineBreakMode) -> [NSAttributedString.Key: Any]
}

public extension DKTextField {

    func getStringAttributes(currentAlignment: NSTextAlignment = .left,
                             lineBreakMode: NSLineBreakMode = .byWordWrapping) -> [NSAttributedString.Key: Any] {
        let style = NSMutableParagraphStyle()
        style.alignment = currentAlignment
        style.lineBreakMode = lineBreakMode
        return [NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: textColor,
                NSAttributedString.Key.paragraphStyle: style]
    }
}

// MARK: - DKTextFormField

public protocol DKTextFormField: DKTextField {
    var focusedColor: UIColor { get }
    var unfocusedColor: UIColor { get }
    var errorColor: UIColor { get }
    var disabledColor: UIColor { get }
}

// MARK: - DKNavigationBar

public protocol DKNavigationBar {
    var font: UIFont { get }
    var largeFont: UIFont { get }
    var titleColor: UIColor { get }
    var tintColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var backButtonStyleColor: UIColor { get }
    var defaultButtonStyleColor: UIColor { get }
    var doneButtonStyleColor: UIColor { get }
    var prefersLargeTitles: Bool { get }

    func getTitleTextAttributes() -> [NSAttributedString.Key: Any]
    func getLargeTitleTextAttributes() -> [NSAttributedString.Key: Any]
}

public extension DKNavigationBar {

    func getTitleTextAttributes() -> [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: titleColor]
    }

    func getLargeTitleTextAttributes() -> [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.font: largeFont,
                NSAttributedString.Key.foregroundColor: titleColor]
    }

    func getBackButtonTitleTextAttributes(for state: UIControl.State) -> [NSAttributedString.Key: Any] {
        switch state {
        case .selected:
            return [NSAttributedString.Key.font: DKDefaultThemeFonts.shared.body,
                    NSAttributedString.Key.foregroundColor: DKDefaultThemeColors.shared.neutral2]
        default:
            return [NSAttributedString.Key.font: DKDefaultThemeFonts.shared.body,
                    NSAttributedString.Key.foregroundColor: backButtonStyleColor]
        }
    }

    func getDefaultButtonTitleTextAttributes(for state: UIControl.State) -> [NSAttributedString.Key: Any] {
        switch state {
        case .selected:
            return [NSAttributedString.Key.font: DKDefaultThemeFonts.shared.body,
                    NSAttributedString.Key.foregroundColor: DKDefaultThemeColors.shared.neutral2]
        default:
            return [NSAttributedString.Key.font: DKDefaultThemeFonts.shared.body,
                    NSAttributedString.Key.foregroundColor: defaultButtonStyleColor]
        }
    }

    func getDoneButtonTitleTextAttributes(for state: UIControl.State) -> [NSAttributedString.Key: Any] {
        switch state {
        case .selected:
            return [NSAttributedString.Key.font: DKDefaultThemeFonts.shared.small,
                    NSAttributedString.Key.foregroundColor: DKDefaultThemeColors.shared.link]
        default:
            return [NSAttributedString.Key.font: DKDefaultThemeFonts.shared.small,
                    NSAttributedString.Key.foregroundColor: doneButtonStyleColor]
        }
    }
}

// MARK: - DKTabBar

public protocol DKTabBar {
    var font: UIFont { get }
    var titleColor: UIColor { get }
    var selectedTitleColor: UIColor { get }
    var backgroundColor: UIColor { get }

    func getTitleTextAttributes() -> [NSAttributedString.Key: Any]
    func getSelectedTitleTextAttributes() -> [NSAttributedString.Key: Any]
}

public extension DKTabBar {

    func getTitleTextAttributes() -> [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: titleColor]
    }

    func getSelectedTitleTextAttributes() -> [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: selectedTitleColor]
    }
}

// MARK: - DKSegmentedControl

public enum DKSegmentedControlSelectionStyle {
    case background
    case underlineBar(color: UIColor)
}

public protocol DKSegmentedControl {
    var font: UIFont { get }
    var selectedFont: UIFont { get }
    var borderColor: UIColor { get }
    var textColor: UIColor { get }
    var selectedTextColor: UIColor { get }
    var selectionStyle: DKSegmentedControlSelectionStyle { get }
    var equalWidthSegments: Bool { get }
    var height: CGFloat { get }

    func getStringAttributes() -> [NSAttributedString.Key: Any]
    func getSelectedStringAttributes() -> [NSAttributedString.Key: Any]
}

public extension DKSegmentedControl {

    func getStringAttributes() -> [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: textColor]
    }

    func getSelectedStringAttributes() -> [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.font: selectedFont,
                NSAttributedString.Key.foregroundColor: selectedTextColor]
    }
}

// MARK: - DKImageView

public protocol DKImage {
    var tintColor: UIColor { get }
}

// MARK: - DKSwitch

public protocol DKSwitch {
    var tintColor: UIColor { get }
}

// MARK: - DKTheme Style

public protocol DKThemeLabelStyleProtocol {
    var type: DKLabel { get }
    var rawValue: String { get }
}

public protocol DKThemeButtonStyleProtocol {
    var type: DKButton { get }
    var rawValue: String { get }
}

public protocol DKThemeToggleStyleProtocol {
    var type: DKToggleButton { get }
    var rawValue: String { get }
}

public protocol DKThemeTextFieldStyleProtocol {
    var type: DKTextField { get }
    var rawValue: String { get }
}

public protocol DKThemeTextFormFieldStyleProtocol {
    var type: DKTextFormField { get }
    var rawValue: String { get }
}

public protocol DKThemeNavigationBarStyleProtocol {
    var type: DKNavigationBar { get }
    var rawValue: String { get }
}

public protocol DKThemeTabBarStyleProtocol {
    var type: DKTabBar { get }
    var rawValue: String { get }
}

public protocol DKThemeSegmentedControlsStyleProtocol {
    var type: DKSegmentedControl { get }
    var rawValue: String { get }
}

public protocol DKThemeImageStyleProtocol {
    var type: DKImage { get }
    var rawValue: String { get }
}

public protocol DKThemeSwitchStyleProtocol {
    var type: DKSwitch { get }
    var rawValue: String { get }
}

public enum DKThemeLabelStyle: String, DKThemeLabelStyleProtocol {
    case h1Primary,
         h1Link,
         h1Rev,
         h2Primary,
         h2Link,
         h2Rev,
         h3Primary,
         h3Secondary,
         h3Link,
         h3Rev,
         h3Warning,
         h3Danger,
         h3Success,
         h4Primary,
         h4Button,
         h4Secondary,
         h4Link,
         h4Rev,
         h4Warning,
         h4Danger,
         h4Success,
         bodyPrimary,
         bodySecondary,
         bodyLink,
         bodyRev,
         bodyWarning,
         bodyDanger,
         bodySuccess,
         smallBoldPrimary,
         smallBoldButton,
         smallBoldSecondary,
         smallBoldLink,
         smallBoldRev,
         smallBoldWarning,
         smallBoldDanger,
         smallBoldSuccess,
         smallPrimary,
         smallSecondary,
         smallLink,
         smallRev,
         smallWarning,
         smallDanger,
         smallSuccess,
         microPrimary,
         microSecondary,
         microLink,
         microRev

    public var type: DKLabel {
        switch self {
        case .h1Primary:
            return DKTheme.H1Primary()
        case .h1Link:
            return DKTheme.H1Link()
        case .h1Rev:
            return DKTheme.H1Rev()
        case .h2Primary:
            return DKTheme.H2Primary()
        case .h2Link:
            return DKTheme.H2Link()
        case .h2Rev:
            return DKTheme.H2Rev()
        case .h3Primary:
            return DKTheme.H3Primary()
        case .h3Secondary:
            return DKTheme.H3Secondary()
        case .h3Link:
            return DKTheme.H3Link()
        case .h3Rev:
            return DKTheme.H3Rev()
        case .h3Warning:
            return DKTheme.H3Warning()
        case .h3Danger:
            return DKTheme.H3Danger()
        case .h3Success:
            return DKTheme.H3Success()
        case .h4Primary:
            return DKTheme.H4Primary()
        case .h4Button:
            return DKTheme.H4Button()
        case .h4Secondary:
            return DKTheme.H4Secondary()
        case .h4Link:
            return DKTheme.H4Link()
        case .h4Rev:
            return DKTheme.H4Rev()
        case .h4Warning:
            return DKTheme.H4Warning()
        case .h4Danger:
            return DKTheme.H4Danger()
        case .h4Success:
            return DKTheme.H4Success()
        case .bodyPrimary:
            return DKTheme.BodyPrimary()
        case .bodySecondary:
            return DKTheme.BodySecondary()
        case .bodyLink:
            return DKTheme.BodyLink()
        case .bodyRev:
            return DKTheme.BodyRev()
        case .bodyWarning:
            return DKTheme.BodyWarning()
        case .bodyDanger:
            return DKTheme.BodyDanger()
        case .bodySuccess:
            return DKTheme.BodySuccess()
        case .smallBoldPrimary:
            return DKTheme.SmallBoldPrimary()
        case .smallBoldButton:
            return DKTheme.SmallBoldButton()
        case .smallBoldSecondary:
            return DKTheme.SmallBoldSecondary()
        case .smallBoldLink:
            return DKTheme.SmallBoldLink()
        case .smallBoldRev:
            return DKTheme.SmallBoldRev()
        case .smallBoldWarning:
            return DKTheme.SmallBoldWarnings()
        case .smallBoldDanger:
            return DKTheme.SmallBoldDanger()
        case .smallBoldSuccess:
            return DKTheme.SmallBoldSuccess()
        case .smallPrimary:
            return DKTheme.SmallPrimary()
        case .smallSecondary:
            return DKTheme.SmallSecondary()
        case .smallLink:
            return DKTheme.SmallLink()
        case .smallRev:
            return DKTheme.SmallRev()
        case .smallWarning:
            return DKTheme.SmallWarning()
        case .smallDanger:
            return DKTheme.SmallDanger()
        case .smallSuccess:
            return DKTheme.SmallSuccess()
        case .microPrimary:
            return DKTheme.MicroPrimary()
        case .microSecondary:
            return DKTheme.MicroSecondary()
        case .microLink:
            return DKTheme.MicroLink()
        case .microRev:
            return DKTheme.MicroRev()
        }
    }

    public var rawValue: String {
        return String(describing: self)
    }
}

public enum DKThemeButtonStyle: String, DKThemeButtonStyleProtocol {
    case primaryButton,
         primaryAltButton,
         secondaryButton,
         destructiveButton,
         smallPrimaryButton,
         smallSecondaryButton,
         smallDestructiveButton,
         primaryTextButton

    public var type: DKButton {
        switch self {
        case .primaryButton:
            return DKTheme.PrimaryButton()
        case .primaryAltButton:
            return DKTheme.PrimaryAltButton()
        case .secondaryButton:
            return DKTheme.SecondaryButton()
        case .destructiveButton:
            return DKTheme.DestructiveButton()
        case .smallPrimaryButton:
            return DKTheme.SmallPrimaryButton()
        case .smallSecondaryButton:
            return DKTheme.SmallSecondaryButton()
        case .smallDestructiveButton:
            return DKTheme.SmallDestructiveButton()
        case .primaryTextButton:
            return DKTheme.PrimaryTextButton()
        }
    }

    public var rawValue: String {
        return String(describing: self)
    }
}

public enum DKToggleButtonStyle: String, DKThemeToggleStyleProtocol {
    case defaultRadioButton
    case defaultCheckboxButton

    public var type: DKToggleButton {
        switch self {
        case .defaultRadioButton:
            return DKTheme.DefaultRadioButton()
        case .defaultCheckboxButton:
            return DKTheme.DefaultCheckboxButton()
        }
    }

    public var rawValue: String {
        return String(describing: self)
    }
}

public enum DKThemeTextFieldStyle: String, DKThemeTextFieldStyleProtocol {
    case defaultTextField

    public var type: DKTextField {
        switch self {
        case .defaultTextField:
            return DKTheme.DefaultTextField()
        }
    }

    public var rawValue: String {
        return String(describing: self)
    }
}

public enum DKThemeTextFormFieldStyle: String, DKThemeTextFormFieldStyleProtocol {
    case defaultTextFormField

    public var type: DKTextFormField {
        switch self {
        case .defaultTextFormField:
            return DKTheme.DefaultTextFormField()
        }
    }

    public var rawValue: String {
        return String(describing: self)
    }
}

public enum DKThemeNavigationBarStyle: String, DKThemeNavigationBarStyleProtocol {
    case defaultNavigationBar,
        reverseNavigationBar,
        blackTintedNavigationBar

    public var type: DKNavigationBar {
        switch self {
        case .defaultNavigationBar:
            return DKTheme.DefaultNavigationBar()
        case .reverseNavigationBar:
            return DKTheme.ReverseNavigationBar()
        case .blackTintedNavigationBar:
            return DKTheme.BlackTintedNavigationBar()
        }
    }

    public var rawValue: String {
        return String(describing: self)
    }
}

public enum DKThemeTabBarStyle: String, DKThemeTabBarStyleProtocol {
    case defaultTabBar,
        reverseTabBar,
        blackTintedTabBar

    public var type: DKTabBar {
        switch self {
        case .defaultTabBar:
            return DKTheme.DefaultTabBar()
        case .reverseTabBar:
            return DKTheme.ReverseTabBar()
        case .blackTintedTabBar:
            return DKTheme.BlackTintedDefaultTabBar()
        }
    }

    public var rawValue: String {
        return String(describing: self)
    }
}

public enum DKThemeSegmentControlStyle: String, DKThemeSegmentedControlsStyleProtocol {
    case defaultSegmentedControl,
        underlinedSegmentedControl

    public var type: DKSegmentedControl {
        switch self {
        case .defaultSegmentedControl:
            return DKTheme.DefaultSegmentedControl()
        case .underlinedSegmentedControl:
            return DKTheme.UnderlinedSegmentedControl()
        }
    }

    public var rawValue: String {
        return String(describing: self)
    }
}

public enum DKThemeImageStyle: DKThemeImageStyleProtocol {
    case defaultImage

    public var type: DKImage {
        switch self {
        case .defaultImage:
            return DKTheme.DefaultImage()
        }
    }

    public var rawValue: String {
        return String(describing: self)
    }
}

public enum DKThemeSwitchStyle: String, DKThemeSwitchStyleProtocol {
    case defaultSwitch

    public var type: DKSwitch {
        switch self {
        case .defaultSwitch:
            return DKTheme.DefaultSwitch()
        }
    }

    public var rawValue: String {
        return String(describing: self)
    }
}
