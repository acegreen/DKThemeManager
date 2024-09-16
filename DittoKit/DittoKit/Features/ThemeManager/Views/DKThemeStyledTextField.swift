//
//  DKThemeStyledTextField.swift
//  DittoKit
//
//  Created by Ace Green on 1/8/21.
//

import UIKit

@IBDesignable
open class DKThemeStyledTextField: UITextField {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        update(newText: self.text)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        update(newText: self.text)
    }

    // Programmatically: use the enum
    public var themedStyle: DKThemeTextFieldStyle = .defaultTextField {
        didSet {
            update(newText: self.text)
            font = themedStyle.type.font
        }
    }
    // Currently no requirement to change padding as make it to 16.
    public var rightViewPadding: CGFloat = 16

    // set the rightViewImage
    public var rightViewImage: UIImage? = nil {
        didSet {
            if let rightViewImage = rightViewImage {
                let imageView = UIImageView(image: rightViewImage)
                if let imageSize = imageView.image?.size {
                    let view = UIView(frame: CGRect(x: 0, y: 0, width: imageSize.width + rightViewPadding, height: imageSize.height))
                    view.addSubview(imageView)
                    rightView = view
                    rightViewMode = .always
                }
            } else {
                rightView = nil
                rightViewMode = .never
            }
        }
    }

    // IB: use the adapter
    @IBInspectable public var themedStyleAdapter: String {
        get {
            return self.themedStyle.rawValue
        }
        set(index) {
            self.themedStyle = DKThemeTextFieldStyle(rawValue: index) ?? .defaultTextField
        }
    }

    public override var text: String? {
        didSet {
            update(newText: self.text)
        }
    }

    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        if let contentInsets = themedStyle.type.contentInsets {
            return bounds.inset(by: contentInsets)
        }
        return .zero
    }

    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        if let contentInsets = themedStyle.type.contentInsets {
            return bounds.inset(by: contentInsets)
        }
        return .zero
    }

    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        if let contentInsets = themedStyle.type.contentInsets {
            return bounds.inset(by: contentInsets)
        }
        return .zero
    }

    private func update(newText: String?) {
        let unwrappedText = newText ?? ""
        attributedText = NSAttributedString(string: unwrappedText, attributes: themedStyle.type.getStringAttributes())
        accessibilityLabel = newText
        adjustsFontForContentSizeCategory = true
        updateStyle()
    }

    private func updateStyle() {
        tintColor = themedStyle.type.tintColor
        backgroundColor = themedStyle.type.backgroundColor
        heightAnchor.constraint(equalToConstant: themedStyle.type.height).isActive = true
    }

    func addAttributes(attributes: [NSAttributedString.Key: Any], forRange range: NSRange) {
        guard let currentText = text else {
            return
        }
        let attributedString = NSMutableAttributedString(string: currentText, attributes: themedStyle.type.getStringAttributes())
        attributedString.addAttributes(attributes, range: range)
        attributedText = attributedString
    }
}
