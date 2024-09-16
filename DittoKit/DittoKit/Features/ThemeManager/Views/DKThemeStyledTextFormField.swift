//
//  DKThemeStyledTextFormField.swift
//  DittoKit
//
//  Created by Ace Green on 1/8/21.
//

import UIKit

public enum DKTextFormFieldInputKind {
    case keyboard(type: UIKeyboardType),
    datePicker,
    other

    public static func asciiCapableKeyboard() -> DKTextFormFieldInputKind {
        return DKTextFormFieldInputKind.keyboard(type: .asciiCapable)
    }
}

extension DKTextFormFieldInputKind: Equatable {
    public static func == (lhs: DKTextFormFieldInputKind, rhs: DKTextFormFieldInputKind) -> Bool {
        switch (lhs, rhs) {
        case let (.keyboard(type1), .keyboard(type2)):
            return type1 == type2
        case (.datePicker, .datePicker), (.other, .other):
            return true
        default:
            return false
        }
    }
}

/// A type for possible validation errors in a text form field and how to check for their existance.
public protocol DKTextFormFieldValidationError: Error {

    /// A closure containing the logic to test if a given validation error case exists.
    var containsValidationError: (String) -> Bool { get }
}

public typealias DKTextFormFieldBecomeFirstResponderBlock = ((_ formField: DKThemeStyledTextFormField) -> Void)

@IBDesignable
open class DKThemeStyledTextFormField: DKFormField, DKFormFieldValidationProtocol {

    // Programmatically: use the enum
    public var themedStyle: DKThemeTextFormFieldStyle = .defaultTextFormField {
        didSet {
            update(with: nil)
        }
    }

    // IB: use the adapter
    @IBInspectable public var themedStyleAdapter: String {
        get {
            return self.themedStyle.rawValue
        }
        set(index) {
            self.themedStyle = DKThemeTextFormFieldStyle(rawValue: index) ?? .defaultTextFormField
        }
    }

    public enum DKFormFieldState {
        case unfocusKeyboardInput, focusKeyboardInput, validationErrorKeyboardInput
        case unfocusPickerInput, focusPickerInput, validationErrorPickerInput

        var rightViewImage: UIImage? {
            let image = DKRDSIcons.arrowDown.image
            switch self {
            case .unfocusKeyboardInput, .focusKeyboardInput, .validationErrorKeyboardInput:
                return nil
            case .unfocusPickerInput, .focusPickerInput, .validationErrorPickerInput:
                return image?.tintedImage(with: DKThemeManager.shared.current.colors.neutral2)
            }
        }

        var rightCalendarImage: UIImage? {
            let image = DKRDSIcons.calendar.image
            switch self {
            case .unfocusKeyboardInput, .focusKeyboardInput, .validationErrorKeyboardInput:
                return nil
            case .unfocusPickerInput, .focusPickerInput, .validationErrorPickerInput:
                return image?.tintedImage(with: DKThemeManager.shared.current.colors.neutral2)
            }
        }

        var backgroundColor: UIColor {
            switch self {
            case .validationErrorKeyboardInput, .validationErrorPickerInput:
                // Hardcoded as no requirement to change
                return #colorLiteral(red: 1, green: 0.9607843137, blue: 0.968627451, alpha: 1)
            default:
                return DKThemeManager.shared.current.colors.white
            }
        }

        var borderColor: UIColor {
            switch self {
            case .unfocusKeyboardInput, .unfocusPickerInput:
                return DKThemeManager.shared.current.colors.neutral2
            case .focusKeyboardInput, .focusPickerInput:
                return DKThemeManager.shared.current.colors.brand
            case .validationErrorKeyboardInput, .validationErrorPickerInput:
                return DKThemeManager.shared.current.colors.feedbackDangerDark
            }
        }

        var borderWidth: CGFloat {
            switch self {
            case .unfocusKeyboardInput, .unfocusPickerInput:
                return 1
            default:
                return 2
            }
        }
        var cornerRadius: CGFloat {
            switch self {
            default:
                return 4
            }
        }
    }

    public override var isUserInteractionEnabled: Bool {
        didSet {
            if isUserInteractionEnabled == false {
                inputField.backgroundColor = themedStyle.type.disabledColor
            }
        }
    }
    public var hideConstraint: NSLayoutConstraint?
    public var contentInset: UIEdgeInsets? {
        didSet {
            applyConstraints()
        }
    }

    public var state: DKFormFieldState = .unfocusKeyboardInput {
        didSet {
            setStyle(for: state)
        }
    }

    public var inputKind = DKTextFormFieldInputKind.keyboard(type: .default) {
        didSet {
            updateInputKind()
        }
    }

    // MARK: - FormElement Subclass Hook
    public override var elementValue: Any? {
        get {
            return inputField.text
        }
        set {
            inputField.text = newValue as? String
        }
    }

    public var dateValue: Date? {
        if let dateText = inputField.text {
            return dateFormatter.date(from: dateText)
        }
        return nil
    }

    @IBOutlet public weak var inputField: DKThemeStyledTextField!
    @IBOutlet public weak var fieldInfoLabel: DKThemeStyledLabel!
    @IBOutlet public weak var hintLabel: DKThemeStyledLabel!
    @IBOutlet public weak var loadedView: UIView!
    @IBOutlet public weak var bottomErrorView: DKThemeStyledTextFormErrorView!
    @IBOutlet public weak var inputFieldStackView: UIStackView!

    @IBOutlet weak var inputFieldStackTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var inputFieldStackBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var inputFieldStackLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var inputFieldStackTrailingConstraint: NSLayoutConstraint!
    @IBOutlet public weak var inputFieldHeightConstraint: NSLayoutConstraint!

    var dateFormatter = DateFormatter()
    public var becomeFirstResponderBlock: DKTextFormFieldBecomeFirstResponderBlock?
    private var datePicker: UIDatePicker?
    open var markForValidation = false

    @IBInspectable public var fieldInfoText: String = "" {
        didSet {
            fieldInfoLabel.text = fieldInfoText
        }
    }

    public var bottomErrorViewVisible: Bool = false {
        didSet {
            bottomErrorView.isHidden = !bottomErrorViewVisible
        }
    }

    public var errorViewImage: UIImage? = DKRDSIcons.alert.image?.tintedImage(with: DKThemeManager.shared.current.colors.feedbackDangerDark) {
        didSet {
            bottomErrorView.errorImage = errorViewImage
        }
    }

    @IBInspectable public var showsDropdownIcon: Bool = false {
        didSet {
            if showsDropdownIcon {
                switch inputKind {
                case .datePicker:
                    inputField.rightViewImage = DKFormFieldState.unfocusPickerInput.rightCalendarImage
                case .other:
                    inputField.rightViewImage = DKFormFieldState.unfocusPickerInput.rightViewImage
                case .keyboard:
                    inputField.rightViewImage = nil
                }
            } else {
                inputField.clearButtonMode = .never
                inputField.rightViewImage = (DKRDSIcons.clear.image)?.tintedImage(with: DKThemeManager.shared.current.colors.neutral1)
                inputField.rightView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.clearText(_:))))
                inputField.rightViewMode = .whileEditing
            }
        }
    }

    @IBInspectable public var placeHolderText: String? {
        didSet {
            inputField.placeholder = placeHolderText
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    func loadNib() {
        UIView.setupNib(named: String(describing: DKThemeStyledTextFormField.self),
                        superview: self,
                        bundle: DKBundleHelper.bundle(named: DittoKit.bundleName))
    }

    private func setUp() {
        loadNib()
        inputField.accessibilityIdentifier = identifier
        inputField.addTarget(self, action: #selector(self.textDidChange), for: .editingChanged)
        inputField.returnKeyType = .default
        // Set default value to false and set clear button rightView
        showsDropdownIcon = false
        NotificationCenter.default.addObserver(self, selector: #selector(self.didBecomeFirstResponder),
                                               name: UITextField.textDidBeginEditingNotification,
                                               object: inputField)
        dateFormatter.dateFormat = "MM/dd/yyyy"
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleSingleTap(_:))))
        //HintLabel default hidden is true
        hintLabel.isHidden = true
        setStyle(for: state)
        hideErrorViews()
    }

    // MARK: - Public interface

    public func validate() {
        textDidChange(nil)
    }

    public func forceValidate() {
        markForValidation = true
        validate()
    }

    // MARK: - IB Actions

    @IBAction func textDidChange(_ sender: Any?) {
        guard let internalValidationBlock = internalValidationBlock else {
            updateWithValidationError(nil)
            return
        }
        updateWithValidationError(internalValidationBlock(identifier, inputField.text ?? ""))
    }

    @objc func datePickerValueDidChange(_ sender: UIDatePicker) {
        inputField.text = dateFormatter.string(from: sender.date)
        textDidChange(sender)
    }

    // MARK: - RLYFormElement Subclass Hooks

    @objc func didBecomeFirstResponder() {
        guard let becomeFirstResponderBlock = becomeFirstResponderBlock  else { return }
        becomeFirstResponderBlock(self)
    }

    public override var responderForInput: UIResponder? {
        return inputField
    }

    public override var elementCanBecomeFirstResponder: Bool {
        return inputField.canBecomeFirstResponder
    }

    public override func elementBecomeFirstResponder(with direction: DKFormCycleDirection) {
        inputField.becomeFirstResponder()
    }

    // MARK: - Private interface
    @objc private func handleSingleTap(_ recognizer: UITapGestureRecognizer) {
        guard isFirstResponder == false && elementCanBecomeFirstResponder == true else { return }
        inputField.becomeFirstResponder()
    }

    // clear inputField text to clear
    @objc private func clearText(_ recognizer: UITapGestureRecognizer) {
        inputField.text = nil
        inputField.resignFirstResponder()
    }

    private func updateInputKind() {
        switch inputKind {
        case .keyboard(let keyboardType):
            inputField.keyboardType = keyboardType
            inputField.inputView = nil
            showsDropdownIcon = false
        case .datePicker:
            datePicker = UIDatePicker()
            datePicker?.addTarget(self, action: #selector(self.datePickerValueDidChange(_:)), for: .valueChanged)
            datePicker?.datePickerMode = .date
            if #available(iOS 13.4, *) {
                datePicker?.preferredDatePickerStyle = .wheels
            }
            inputField.inputView = datePicker
            showsDropdownIcon = true
        case .other:
            showsDropdownIcon = true
        }
    }

    private func updateWithValidationError(_ error: DKFormValidationError?) {
        guard markForValidation else { return }
        update(with: error)
        if let error = error {
            renderStyle(forValidationError: error)
        } else if inputField.isFirstResponder {
            renderFocusStyle()
        } else {
            renderUnfocusStyle()
        }
        delegate?.formElement(self, didUpdate: error)
    }

    private func renderStyle(forValidationError error: DKFormValidationError) {
        let errorDescription = !error.errorDescription.isEmpty ? error.errorDescription : ""

        switch inputKind {
        case .keyboard:
            showBottomErrorView(withDescription: errorDescription)
        case .datePicker, .other:
            showBottomErrorView(withDescription: errorDescription)
        }

        switch inputKind {
        case .keyboard:
            state = .validationErrorKeyboardInput
        case .datePicker, .other:
            state = .validationErrorPickerInput
        }
        setStyle(for: state)
        setNeedsUpdateConstraints()
    }

    public func renderFocusStyle() {
        var state: DKFormFieldState
        switch inputKind {
        case .keyboard:
            state = .focusKeyboardInput
        case .datePicker, .other:
            state = .focusPickerInput
        }
        setStyle(for: state)
        hideErrorViews()
    }

    public func renderUnfocusStyle() {
        var state: DKFormFieldState
        switch inputKind {
        case .keyboard:
            state = .unfocusKeyboardInput
        case .datePicker, .other:
            state = .unfocusPickerInput
        }
        setStyle(for: state)
        hideErrorViews()
    }

    private func setStyle(for state: DKFormFieldState) {
        if case .datePicker = inputKind {
            updateRightView(state.rightCalendarImage)
        } else {
            updateRightView(state.rightViewImage)
        }
        setBackgroundColor(state.backgroundColor)
        inputField.borderColor = state.borderColor
        inputField.borderWidth = state.borderWidth
        inputField.cornerRadius = state.cornerRadius
        if state == .focusPickerInput || state == .focusKeyboardInput {
            inputField.layer.masksToBounds = false
            inputField.layer.shadowColor = state.borderColor.cgColor
            inputField.layer.shadowOffset = .zero
            inputField.layer.shadowOpacity = 0.6
            inputField.layer.shadowRadius = 4
        } else {
            inputField.layer.shadowOffset = .zero
            inputField.layer.shadowColor = UIColor.clear.cgColor
            inputField.layer.shadowOpacity = 0.0
            inputField.layer.shadowRadius = 0
        }
        setNeedsUpdateConstraints()
    }

    private func updateRightView(_ image: UIImage?) {
        guard showsDropdownIcon, inputField.rightViewMode != .never, let image = image else { return }
        inputField.rightViewImage = image
    }

    private func hideErrorViews() {
        bottomErrorViewVisible = false
        markForValidation = false
        accessibilityHint = nil
    }

    private func showBottomErrorView(withDescription text: String) {
        bottomErrorViewVisible = true
        bottomErrorView.text = text
        accessibilityHint = text
    }

    private func setBackgroundColor(_ color: UIColor) {
        if isUserInteractionEnabled == false {
            inputField.backgroundColor = themedStyle.type.disabledColor
        } else {
            inputField.backgroundColor = color
        }
    }
    /// Helper function that checks if the text form field contains the given validation error.
    ///
    /// - Parameter error: `TextFormFieldValidationError` to search for in the text form field.
    /// - Returns: `TextFormFieldValidationError` if found; otherwise, `nil`
    public func contains(validationError error: DKTextFormFieldValidationError) -> DKTextFormFieldValidationError? {
        let text = inputField.text ?? ""
        if error.containsValidationError(text) {
            return error
        } else {
            return nil
        }
    }

    /// Checks the text form field for the given validation errors and return any errors found.
    ///
    /// - Parameter errors: An array of `TextFormFieldValidationError`s to search for in the text form field.
    /// - Returns: `[TextFormFieldValidationError]` containing any validation errors found; otherwise, `nil`.
    public func contains(validationErrors errors: [DKTextFormFieldValidationError]) -> [DKTextFormFieldValidationError]? {
        var foundErrors: [DKTextFormFieldValidationError] = []
        errors.forEach { error in
            if let foundError = contains(validationError: error) {
                foundErrors.append(foundError)
            }
        }
        guard !foundErrors.isEmpty else { return nil }
        return foundErrors
    }

    /// For picker based form fields: Sets the given value as the input text and
    /// selects the associated row on the picker (if the value is contained in the selection options)
    ///
    /// - Parameters:
    ///   - value: The `String` to set on the form field's input view.
    ///   - options: The array of selection options the picker will display
    public func setPickerValue(_ value: String?, withSelectionOptions options: [String]?) {
        guard let value = value,
            let options = options,
            inputKind == .other || inputKind == .datePicker,
            let picker = inputField.inputView as? UIPickerView else { return }
        if let index = options.firstIndex(of: value) {
            picker.selectRow(index, inComponent: 0, animated: false)
            inputField.text = value
        }
    }

    public func setDatePickerValue(date: Date) {
        guard let datePicker = datePicker, inputKind == .datePicker else { return }
        datePicker.setDate(date, animated: false)
        inputField.text = dateFormatter.string(from: date)

        datePickerValueDidChange(datePicker)
    }

    public func setDatePickerLimit(minDate: Date, maxDate: Date) {
        datePicker?.minimumDate = minDate
        datePicker?.maximumDate = maxDate
    }

    private func applyConstraints() {
        guard let contentInset = contentInset else { return }
        inputFieldStackTopConstraint.constant = contentInset.top
        inputFieldStackBottomConstraint.constant = contentInset.bottom
        inputFieldStackLeadingConstraint.constant = contentInset.left
        inputFieldStackTrailingConstraint.constant = contentInset.right
    }
}
