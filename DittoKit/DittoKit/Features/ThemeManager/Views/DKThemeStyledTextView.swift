//
//  DKThemeStyledTextView.swift
//  DittoKit
//
//  Created by Ace Green on 1/8/21.
//

import UIKit

@IBDesignable
open class DKThemeStyledTextView: UITextView {

    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
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

    public override var text: String! {
        didSet {
            update(newText: self.text)
        }
    }

    // If this textview has links they can be tracked by setting this property. linkUrlString : correspondingEvent. Leave nil to not track.
    var eventsForLinks: [String: String]?

    // if the button exist in sections they should be listed here
    private var eventSections: [String]?

    private func update(newText: String?) {
        let unwrappedText = newText ?? ""
        attributedText = NSAttributedString(string: unwrappedText, attributes: themedStyle.type.getStringAttributes())
        // get link text color from any interactive label style
        linkTextAttributes = [NSAttributedString.Key.foregroundColor: DKTheme.BodyLink().textColor]
        tintColor = themedStyle.type.tintColor
        accessibilityLabel = newText
        adjustsFontForContentSizeCategory = true
    }

    func addAttributes(attributes: [NSAttributedString.Key: Any], forRange range: NSRange) {
        guard let currentText = text else {
            return
        }
        let attributedString = NSMutableAttributedString(string: currentText, attributes: themedStyle.type.getStringAttributes())
        attributedString.addAttributes(attributes, range: range)
        attributedText = attributedString
    }

    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let index = self.layoutManager.characterIndex(for: point, in: self.textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        if NSRange(location: 0, length: attributedText.length).contains(index) {
            let attributes = attributedText.attributes(at: index, longestEffectiveRange: nil, in: NSRange(location: index, length: 1))

            if let link = attributes[NSAttributedString.Key.link] as? String {
                didTapLink(link: link)
            }
        }
        return super.hitTest(point, with: event)
    }

    private func didTapLink(link: String) {
        guard let event = eventsForLinks?[link] else { return }
        shouldTrack(event: event, inSections: eventSections)
    }
}
