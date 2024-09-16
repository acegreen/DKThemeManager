//
//  DKThemeStyledLabel.swift
//  DittoKit
//
//  Created by Ace Green on 1/8/21.
//

import UIKit

@IBDesignable
open class DKThemeStyledLabel: UILabel {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        update(newText: self.text)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        update(newText: self.text)
    }

    // Programmatically: use the enum
    public var themedStyle: DKThemeLabelStyle = .h1Primary {
        didSet {
            update(newText: self.text)
        }
    }

    // IB: use the adapter
    @IBInspectable public var themedStyleAdapter: String {
        get {
            return self.themedStyle.rawValue
        }
        set(index) {
            self.themedStyle = DKThemeLabelStyle(rawValue: index) ?? .h1Primary
        }
    }

    public override var text: String? {
        didSet {
            update(newText: self.text)
            accessibilityLabel = self.text
        }
    }

    private func update(newText: String?) {
        let unwrappedText = newText ?? ""
        let attributes = themedStyle.type.getStringAttributes(currentAlignment: self.textAlignment, lineBreakMode: self.lineBreakMode)
        attributedText = NSAttributedString(string: unwrappedText, attributes: attributes)
        adjustsFontForContentSizeCategory = true
        backgroundColor = themedStyle.type.backgroundColor
    }
}
