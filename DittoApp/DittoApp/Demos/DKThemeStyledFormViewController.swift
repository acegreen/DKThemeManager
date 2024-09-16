//
//  DKThemeStyledFormViewController.swift
//  DittoApp
//
//  Created by Ace Green on 4/28/21.
//

import UIKit
import DittoKit

enum DKFormDetailsFields: Int, DKFormFields, CaseIterable {

    case firstName
    case lastName
    case country
    case street1
    case street2
    case city
    case state
    case zipCode

    var identifier: String {
        switch self {
        case .firstName: return "firstNameFieldIdentifier"
        case .lastName: return "lastNameFieldIdentifier"
        case .country: return "countryFieldIdentifier"
        case .street1: return "streetAddres1FieldIdentifier"
        case .street2: return "streetAddress2FieldIdentifier"
        case .city: return "cityFieldIdentifier"
        case .state: return "stateFieldIdentifier"
        case .zipCode: return "zipCodeFieldIdentifier"
        }
    }

    var fieldLabelInfo: String {
        switch self {
        case .firstName: return "First Name"
        case .lastName: return "Last Name"
        case .country: return "Country"
        case .street1: return "Street 1"
        case .street2: return "Street 2"
        case .city: return "City"
        case .state: return "State"
        case .zipCode: return "Zip Code"
        }
    }

    // Optional default value for the associated form field input
    var defaultValue: String? {
        switch self {
        case .country:
            return "US"
        default:
            return nil
        }
    }

    // Selection options for use with picker based fields
    var selectionOptions: [String]? {
        // swiftlint:disable:next line_length
        let states = ["AL", "AK", "AR", "AS", "AZ", "CA", "CO", "CT", "DC", "DE", "FL", "FM", "GA", "GU", "HI", "IA", "ID", "IL", "IN", "KS", "KY", "LA", "MA", "MD", "ME", "MH", "MI", "MN", "MO", "MP", "MS", "MT", "NC", "ND", "NE", "NH", "NJ", "NM", "NV", "NY", "OH", "OK", "OR", "PA", "PR", "PW", "RI", "SC", "SD", "TN", "TX", "UT", "VA", "VI", "VT", "WA", "WI", "WV", "WY"]

        let countries = ["US"]

        switch self {
        case .country:
            // Insert a placeholder option for use with picker selection
            let placeholder = "Select Option"
            var countries = countries
            countries.insert(placeholder, at: 0)
            return countries
        case .state:
            let placeholder = "Select Option"
            var states = states
            states.insert(placeholder, at: 0)
            return states
        default:
            return nil
        }
    }

    var errorDescriptions: String {
        return "Invalid %@"
    }

    var autocapitalizationType: UITextAutocapitalizationType {
        return .none
    }

    var errorIdentifier: String {
        switch self {
        case .firstName: return "firstNameFieldErrorIdentifier"
        case .lastName: return "lastNameFieldErrorIdentifier"
        case .country: return "countryFieldErrorIdentifier"
        case .street1: return "streetAddres1FieldErrorIdentifier"
        case .street2: return "streetAddress2FieldErrorIdentifier"
        case .city: return "cityFieldErrorIdentifier"
        case .state: return "stateFieldErrorIdentifier"
        case .zipCode: return "zipCodeFieldErrorIdentifier"
        }
    }

    var isBottomErrorView: Bool {
        switch self {
        case .state, .country:
            return false
        default:
            return true
        }
    }

    static var allFields: [DKFormDetailsFields] = DKFormDetailsFields.allCases
}

enum DKFormDetailsFieldError: DKTextFormFieldValidationError {

    case emptyField
    case containsDisallowedCharacters(CharacterSet)
    case exceedsMaximumCharacterCount(Int)
    case belowMinCharacterCount(Int)

    var containsValidationError: (String) -> Bool {
        switch self {
        case .emptyField:
            return { $0.trimmingCharacters(in: CharacterSet(charactersIn: " ")).isEmpty }
        case let .containsDisallowedCharacters(characterSet):
            return { text in
                return text.containsCharacters(from: characterSet)
            }
        case let .exceedsMaximumCharacterCount(count):
            return { $0.count > count }
        case let .belowMinCharacterCount(count):
            return { $0.count < count }
        }
    }
}

class DKThemeStyledFormViewController: DKFormViewController {

    // MARK: Outlets

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var headerViewTitleLabel: DKThemeStyledLabel!
    @IBOutlet weak var headerViewSubTitleLabel: DKThemeStyledLabel!
    @IBOutlet weak var footerViewButton: DKThemeStyledButton!

    private let maxNameAllowedLength = 50
    private let allowedZipcodeLength = 5

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFields()
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        forceUpdateStyles()
    }

    private func forceUpdateStyles() {
        let navigationBar = navigationController as? DKThemeStyledNavigationController
        navigationBar?.themedStyle = client == .uhc ? .reverseNavigationBar : .blackTintedNavigationBar
        footerViewButton.themedStyle = .primaryButton
    }

    private func setupViews() {
        formView.screenMode = .full
        formView.headerView = headerView
        formView.footerView = footerView
        formView.focusToolbar.isTranslucent = true
        formView.formDelegate = self
        formView.alwaysBounceVertical = true

        headerViewTitleLabel.text = "Where should we send it?"
        headerViewSubTitleLabel.text = "Please enter your contact and shipping information below."

        footerViewButton.setTitle("Continue", for: .normal)
    }

    private func setupFields() {
        let disallowedCharacters = CharacterSet(charactersIn: "!@%^*()_+=\\][{}|”“;:?><`~")
        let disallowedCityCharacters = CharacterSet.decimalDigits

        var elements: [DKThemeStyledTextFormField] = []
        DKFormDetailsFields.allFields.forEach { formField in
            let field = formFieldFor(formField)

            switch formField {
            case .firstName, .lastName:
                field.inputKind = DKTextFormFieldInputKind.asciiCapableKeyboard()
                setValidationBlock(for: field, withValidationErrors: [.emptyField,
                                                                      .containsDisallowedCharacters(disallowedCharacters),
                                                                      .exceedsMaximumCharacterCount(maxNameAllowedLength)])
            case .street1:
                field.inputKind = DKTextFormFieldInputKind.asciiCapableKeyboard()
                setValidationBlock(for: field, withValidationErrors: [.emptyField, .containsDisallowedCharacters(disallowedCharacters)])
            case .city:
                field.inputKind = DKTextFormFieldInputKind.asciiCapableKeyboard()
                setValidationBlock(for: field, withValidationErrors: [.emptyField, .containsDisallowedCharacters(disallowedCityCharacters)])
            case .zipCode:
                field.inputKind = DKTextFormFieldInputKind.asciiCapableKeyboard()
                setValidationBlock(for: field, withValidationErrors: [.emptyField,
                                                                      .exceedsMaximumCharacterCount(allowedZipcodeLength),
                                                                      .belowMinCharacterCount(allowedZipcodeLength)])
                field.inputField.keyboardType = .numberPad
            case .street2:
                field.inputKind = DKTextFormFieldInputKind.asciiCapableKeyboard()
                setValidationBlock(for: field, withValidationErrors: [.containsDisallowedCharacters(disallowedCharacters)])
            case .country:
                setupPickerViewFor(shippingField: formField, formField: field)
                field.isUserInteractionEnabled = false
                // remove this line when we support multiple country to show drop down
                field.inputField.rightViewMode = .never
                field.inputField.accessibilityTraits = .staticText
            case .state:
                setupPickerViewFor(shippingField: formField, formField: field)
            }
            field.inputField.accessibilityIdentifier = formField.identifier
            field.renderUnfocusStyle()
            elements.append(field)
        }
        formView.elements = elements
    }

    private func setupPickerViewFor(shippingField: DKFormDetailsFields, formField: DKThemeStyledTextFormField) {
        let pickerView = UIPickerView()
        pickerView.tag = shippingField.rawValue
        pickerView.dataSource = self
        pickerView.delegate = self
        formField.inputField.inputView = pickerView
        formField.inputKind = .other
        formField.setPickerValue(shippingField.defaultValue, withSelectionOptions: shippingField.selectionOptions)
        setValidationBlock(for: formField, withValidationErrors: [.emptyField])
        let attributedPlaceholder = NSAttributedString(string: "Select Option", attributes: DKTheme.BodyPrimary().getStringAttributes())
        formField.inputField.attributedPlaceholder = attributedPlaceholder
    }

    private func formFieldFor(_ formField: DKFormDetailsFields) -> DKThemeStyledTextFormField {
        let field = DKThemeStyledTextFormField(identifier: formField.identifier)
        if formField == .street2 {
            let fullTitleString = formField.fieldLabelInfo
            let currentAttribute: [NSAttributedString.Key: Any] = [
                .font: DKThemeManager.shared.current.fonts.body, .foregroundColor: field.fieldInfoLabel.themedStyle.type.textColor]
            field.fieldInfoLabel.attributedText = NSAttributedString(string: fullTitleString, attributes: currentAttribute)
        } else {
            field.fieldInfoText = formField.fieldLabelInfo
        }
        field.fieldInfoLabel.isAccessibilityElement = false
        field.inputField.delegate = self
        field.inputField.tag = formField.rawValue
        field.inputField.removeTarget(nil, action: nil, for: .editingChanged)
        field.inputField.addTarget(self, action: #selector(DKThemeStyledFormViewController.textChanged(_:)), for: .editingChanged)
        field.becomeFirstResponderBlock = { [weak self] textField in
            guard let strongSelf = self, !strongSelf.fieldHasError(textField) else { return }
            textField.renderFocusStyle()
        }
        let errorView = field.bottomErrorView
        errorView?.accessibilityIdentifier = formField.errorIdentifier
        return field
    }

//    func updateFieldsWith(address userAddress: GiftCardUserAddress) {
//        DKFormDetailsFields.allFields.forEach { formField in
//            let field = getThemeStyledFieldFor(formField.identifier)
//            switch formField {
//            case .firstName:
//                field?.inputField.text = userAddress.firstName
//            case .lastName:
//                field?.inputField.text = userAddress.lastName
//            case .country:
//                field?.setPickerValue(userAddress.address?.country, withSelectionOptions: formField.selectionOptions)
//            case .street1:
//                field?.inputField.text = userAddress.address?.street1
//            case .street2:
//                field?.inputField.text = userAddress.address?.street2
//            case .city:
//                field?.inputField.text = userAddress.address?.city
//            case .state:
//                field?.setPickerValue(userAddress.address?.state, withSelectionOptions: formField.selectionOptions)
//            case .zipCode:
//                field?.inputField.text = userAddress.address?.zipCode
//            }
//        }
//    }

    /// Sets the logic to be performed when validating the given text form field.
    ///
    /// - Parameters:
    ///   - field: The text form field to perform validation on.
    ///   - validations: The types of validation errors to check for.
    private func setValidationBlock(for field: DKThemeStyledTextFormField, withValidationErrors errors: [DKFormDetailsFieldError]) {

        field.internalValidationBlock = {(identifier: String, value: Any) in
            guard let shippingField = DKFormDetailsFields(rawValue: field.inputField.tag) else { return nil }
            let fieldName = shippingField.fieldLabelInfo.lowercased()
            guard field.contains(validationErrors: errors) != nil else { return nil }
            let errorDescription: String = .localizedStringWithFormat(shippingField.errorDescriptions, fieldName)
            return DKFormValidationError(errorDescription: errorDescription)
        }
    }
}

extension DKThemeStyledFormViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        guard let fieldType = DKFormDetailsFields(rawValue: pickerView.tag) else { return 0 }
        var numberOfRows: Int?

        switch fieldType {
        case .country:
            if let options = DKFormDetailsFields.country.selectionOptions {
                numberOfRows = options.count
            }
        case .state:
            if let options = DKFormDetailsFields.state.selectionOptions {
                numberOfRows = options.count
            }
        default:
            break
        }
        return numberOfRows ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        guard let fieldType = DKFormDetailsFields(rawValue: pickerView.tag) else { return nil }

        var title: String?

        switch fieldType {
        case .country:
            if let options = DKFormDetailsFields.country.selectionOptions {
                title = options[row]
            }
        case .state:
            if let options = DKFormDetailsFields.state.selectionOptions {
                title = options[row]
            }
        default:
            break
        }
        return title
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        guard let fieldType = DKFormDetailsFields(rawValue: pickerView.tag) else { return }

        var field: DKThemeStyledTextFormField?
        var selectedOption: String?

        switch fieldType {
        case .country:
            if let options = DKFormDetailsFields.country.selectionOptions {
                selectedOption = options[row]
                field = getThemeStyledFieldFor(DKFormDetailsFields.country.identifier)
            }
        case .state:
            if let options = DKFormDetailsFields.state.selectionOptions {
                selectedOption = options[row]
                field = getThemeStyledFieldFor(DKFormDetailsFields.state.identifier)
            }
        default:
            return
        }

        // Set empty value if placeholder option selected.
        guard row > 0 else {
            field?.inputField.text = nil
            return
        }
        field?.inputField.text = selectedOption
        textChanged(field?.inputField)
    }
}

extension DKThemeStyledFormViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let field = textField.superview(ofType: DKThemeStyledTextFormField.self) {
            field.markForValidation = true
            field.validate()
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        formView.endEditing(true)
        return true
    }

    @objc func textChanged(_ sender: UITextField!) {
        if let field = sender.superview(ofType: DKThemeStyledTextFormField.self) {
            field.markForValidation = true
            if field.identifier == DKFormDetailsFields.zipCode.identifier, field.inputField.text?.count ?? 0 < 5 {
                field.markForValidation = false
            }
            field.validate()
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Zipcode should take only numbers , this check will work for paste action as well
        if let field = textField.superview(ofType: DKThemeStyledTextFormField.self),
           field.identifier == DKFormDetailsFields.zipCode.identifier {
            let isNumber = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
            return isNumber
        }
        return true
    }
}
