//
//  DKThemeStyledViewController.swift
//  DittoApp
//
//  Created by Ace Green on 4/6/21.
//

import UIKit
import DittoKit

// MARK: - Dummy UHC Theme Fonts

public class DKDummyUHCThemeFonts: DKDefaultThemeFonts { }

// MARK: - Dummy UHC Theme Colors

public class DKDummyUHCThemeColors: DKDefaultThemeColors {

    // https://www.figma.com/file/Cf5ywCWg601mK3BgmlbX47/UHC-Mobile-Style-System?node-id=302%3A2106
    public override var brand: UIColor {
        return #colorLiteral(red: 0, green: 0.1490196078, blue: 0.4666666667, alpha: 1) // #002677
    }

    public override var link: UIColor {
        return #colorLiteral(red: 0.09803921569, green: 0.431372549, blue: 0.8117647059, alpha: 1) // #196ECF
    }

    public override var accent: UIColor {
        return #colorLiteral(red: 0, green: 0.1490196078, blue: 0.4666666667, alpha: 1) // #002677
    }

    public override var neutral1: UIColor {
        return #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)  //#333333
    }

    public override var neutral2: UIColor {
        return #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)  //#666666
    }

    public override var neutral3: UIColor {
        return #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)  //#CCCCCC
    }

    public override var neutral4: UIColor {
        return #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)  //#F3F3F3
    }

    public override var white: UIColor {
        return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)  //#FFFFFF
    }

    public override var feedbackInfo: UIColor {
        return #colorLiteral(red: 0, green: 0.5882352941, blue: 0.862745098, alpha: 1)  //#0096DC
    }

    public override var feedbackInfoLight: UIColor {
        return #colorLiteral(red: 0.8980392157, green: 0.9725490196, blue: 0.9843137255, alpha: 1)  //#E5F8FB
    }

    public override var feedbackInfoDark: UIColor {
        return #colorLiteral(red: 0.007843137255, green: 0.2823529412, blue: 0.6745098039, alpha: 1)  //#0248AC
    }

    public override var feedbackWarning: UIColor {
        return #colorLiteral(red: 0.8784313725, green: 0.4078431373, blue: 0, alpha: 1)  //#E06800
    }

    public override var feedbackWarningLight: UIColor {
        return #colorLiteral(red: 1, green: 0.9843137255, blue: 0.9215686275, alpha: 1)  //#FFFBEB
    }

    public override var feedbackWarningDark: UIColor {
        return #colorLiteral(red: 0.7607843137, green: 0.3058823529, blue: 0.07843137255, alpha: 1)  //#C24E14
    }

    public override var feedbackDanger: UIColor {
        return #colorLiteral(red: 0.9411764706, green: 0.2980392157, blue: 0.3411764706, alpha: 1)  //#F04C57
    }

    public override var feedbackDangerLight: UIColor {
        return #colorLiteral(red: 1, green: 0.9607843137, blue: 0.968627451, alpha: 1)  //#FFF5F7
    }

    public override var feedbackDangerDark: UIColor {
        return #colorLiteral(red: 0.6666666667, green: 0.1803921569, blue: 0.137254902, alpha: 1)  //#AA2E23
    }

    public override var feedbackSuccess: UIColor {
        return #colorLiteral(red: 0.1176470588, green: 0.6352941176, blue: 0.1098039216, alpha: 1)  //#1EA21C
    }

    public override var feedbackSuccessLight: UIColor {
        return #colorLiteral(red: 0.9490196078, green: 0.9725490196, blue: 0.9019607843, alpha: 1)  //#F2F8E6
    }

    public override var feedbackSuccessDark: UIColor {
        return #colorLiteral(red: 0, green: 0.4392156863, blue: 0, alpha: 1)  //#007000
    }

    public override var dataViz1: UIColor {
        return #colorLiteral(red: 0, green: 0.5882352941, blue: 0.862745098, alpha: 1)  //#0096DC
    }

    public override var dataViz2: UIColor {
        return #colorLiteral(red: 0.007843137255, green: 0.2823529412, blue: 0.6745098039, alpha: 1)  //#0248AC
    }

    public override var dataViz3: UIColor {
        return #colorLiteral(red: 0.1176470588, green: 0.6352941176, blue: 0.1098039216, alpha: 1)  //#1EA21C
    }

    public override var dataViz4: UIColor {
        return #colorLiteral(red: 0.8784313725, green: 0.4078431373, blue: 0, alpha: 1)  //#E06800
    }

    public override var dataViz5: UIColor {
        return #colorLiteral(red: 0.9411764706, green: 0.2980392157, blue: 0.3411764706, alpha: 1)  //#F04C57
    }
}

// MARK: - DKThemeStyledViewController

enum DKClient: Int, CaseIterable {
    case megazord,
         uhc,
         custom

    var displayName: String {
        return String(describing: self)
    }

    static func getClient(from colors: DKThemeColorsProtocol) -> DKClient {
        switch colors {
        case is DKDummyUHCThemeColors:
            return .uhc
        case is DKCustomThemeColors:
            return .custom
        default:
            return .megazord
        }
    }
}

var client: DKClient = .megazord

class DKThemeStyledViewController: UIViewController, DKDismissable {

    @IBOutlet weak var segmentedControl: DKThemeStyledSegmentedControl!

    @IBOutlet weak var h1PrimaryLabel: DKThemeStyledLabel!
    @IBOutlet weak var h2LinkLabel: DKThemeStyledLabel!
    @IBOutlet weak var h3Rev: DKThemeStyledLabel!
    @IBOutlet weak var h4warning: DKThemeStyledLabel!
    @IBOutlet weak var bodySuccess: DKThemeStyledLabel!

    @IBOutlet weak var primaryButton: DKThemeStyledButton!
    @IBOutlet weak var primaryAltButton: DKThemeStyledButton!
    @IBOutlet weak var primaryAltButtonBackground: UIView! // Here for visuals
    @IBOutlet weak var secondaryButton: DKThemeStyledButton!
    @IBOutlet weak var destructiveButton: DKThemeStyledButton!
    @IBOutlet weak var smallPrimaryButton: DKThemeStyledButton!
    @IBOutlet weak var smallSecondaryButton: DKThemeStyledButton!
    @IBOutlet weak var primaryTextButton: DKThemeStyledButton!

    @IBOutlet weak var textFormField: DKDummyTextFormField!

    @IBOutlet weak var rdsIconCart: DKThemeStyledRDSImageView!
    @IBOutlet weak var rdsIconInfo: DKThemeStyledRDSImageView!
    @IBOutlet weak var rdsIconDate: DKThemeStyledRDSImageView!
    @IBOutlet weak var rdsIconSearch: DKThemeStyledRDSImageView!
    @IBOutlet weak var rdsIconNotification: DKThemeStyledRDSImageView!

    @IBAction func valueChanged(_ sender: DKThemeStyledSegmentedControl) {
        var theme: DKTheme?
        switch sender.selectedSegmentIndex {
        case 0:
            theme = DKTheme(fonts: DKDefaultThemeFonts(), colors: DKDefaultThemeColors())
        case 1:
            theme = DKTheme(fonts: DKDummyUHCThemeFonts(), colors: DKDummyUHCThemeColors())
        case 2:
            theme = DKCustomTheme(primaryColor: UIColor(hex: "#4E158Cff") ?? .purple)
        default: break
        }
        guard let theme = theme else { return }
        DKThemeManager.shared.current = theme
        client = DKClient.getClient(from: DKThemeManager.shared.current.colors)

        forceUpdateStyles()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        client = DKClient.getClient(from: DKThemeManager.shared.current.colors)
        segmentedControl.selectedSegmentIndex = client.rawValue
        textFormField.configure(placeholder: client.displayName)
        textFormField.inputField.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        forceUpdateStyles()
    }

    private func forceUpdateStyles() {
        let navigationBar = navigationController as? DKThemeStyledNavigationController
        navigationBar?.themedStyle = client == .uhc ? .reverseNavigationBar : .blackTintedNavigationBar
        navigationBar?.prefersLargeTitles = client == .uhc ? false : true
        navigationController?.navigationBar.setNeedsLayout()
        segmentedControl.themedStyle = client == .uhc ? .defaultSegmentedControl : .underlinedSegmentedControl
        h1PrimaryLabel.themedStyle = .h1Primary
        h2LinkLabel.themedStyle = .h2Link
        h3Rev.themedStyle = .h3Rev
        h4warning.themedStyle = .h4Warning
        bodySuccess.themedStyle = .bodySuccess

        primaryButton.themedStyle = .primaryButton
        primaryAltButton.themedStyle = .primaryAltButton
        primaryAltButtonBackground.backgroundColor = primaryAltButton.backgroundColor
        secondaryButton.themedStyle = .secondaryButton
        destructiveButton.themedStyle = .destructiveButton
        smallPrimaryButton.themedStyle = .smallPrimaryButton
        smallSecondaryButton.themedStyle = .smallSecondaryButton
        primaryTextButton.themedStyle = .primaryTextButton

        textFormField.configure(placeholder: client.displayName)
        rdsIconCart.rdsIcon = .cart
        rdsIconInfo.rdsIcon = .info
        rdsIconSearch.rdsIcon = .search
        rdsIconDate.rdsIcon = .calendar
        rdsIconNotification.rdsIcon = .notification
        (tabBarController as? DKThemeStyledTabBarController)?.themedStyle = client == .uhc ? .reverseTabBar : .blackTintedTabBar
        tabBarController?.tabBar.setNeedsLayout()
    }
}

@IBDesignable
class DKDummyTextFormField: DKThemeStyledTextFormField {

    enum DummyTextFields: Int, DKFormFields {

        case defaultTextField

        var identifier: String {
            switch self {
            case .defaultTextField: return "defaultDummyTextFieldIdentifier"
            }
        }

        var fieldLabelInfo: String {
            switch self {
            case .defaultTextField:
                return "Text Input"
            }
        }

        // Optional default value for the associated form field input
        var defaultValue: String? {
            switch self {
            case .defaultTextField:
                return ""
            }
        }

        var errorDescriptions: String {
            return ""
        }
    }

    /// The possible validation errors for the shipping details form and condtions to test their existance.
    enum ColorBrandingTextFieldError: DKTextFormFieldValidationError {

        case emptyField
        case containsDisallowedCharacters(CharacterSet)

        var containsValidationError: (String) -> Bool {
            switch self {
            case .emptyField:
                return { $0.trimmingCharacters(in: CharacterSet(charactersIn: " ")).isEmpty }
            case let .containsDisallowedCharacters(characterSet):
                return { text in
                    return text.containsCharacters(from: characterSet)
                }
            }
        }

        var description: String {
            switch self {
            case .emptyField, .containsDisallowedCharacters:
                return NSLocalizedString("Invalid number!", comment: "")
            }
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(placeholder: String) {
        guard let formField = DummyTextFields.allCases.first else { return }
        fieldInfoText = formField.fieldLabelInfo
        placeHolderText = placeholder
        inputKind = .keyboard(type: .decimalPad)
        inputField.tag = formField.rawValue
        inputField.addDoneButton(fromSender: self)
        becomeFirstResponderBlock = { [weak self] textField in
            guard self != nil else { return }
            textField.renderFocusStyle()
        }
        let disallowedCharacters = CharacterSet(charactersIn: "!@%^*()_+=\\][{}|”“;:?><`~")
        setValidationBlock(withValidationErrors: [.emptyField,
                                                  .containsDisallowedCharacters(disallowedCharacters)])
        inputField.removeTarget(nil, action: nil, for: .editingChanged)
        accessibilityIdentifier = formField.identifier
        renderUnfocusStyle()
    }

    /// Sets the logic to be performed when validating the given text form field.
    ///
    /// - Parameters:
    ///   - withValidationErrors: an array of validation errors to check for.
    private func setValidationBlock(withValidationErrors errors: [ColorBrandingTextFieldError]) {
        internalValidationBlock = { (identifier: String, value: Any) in
            guard let error = self.contains(validationErrors: errors)?.first as? ColorBrandingTextFieldError else { return nil }
            let errorDescription = error.description
            // Adding a delay ensures that announcement isn't cancelled by sysyem events
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                UIAccessibility.post(notification: .announcement, argument: errorDescription)
            }
            return DKFormValidationError(errorDescription: errorDescription)
        }
    }
}

extension DKThemeStyledViewController: UITextFieldDelegate {

    fileprivate func markForValidation() {
        if !textFormField.markForValidation {
            textFormField.markForValidation = true
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        markForValidation()
        textFormField.validate()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }

    @objc fileprivate func textChanged(_ sender: UITextField!) {
        textFormField.validate()
    }
}
