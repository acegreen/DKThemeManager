//
//  DKThemeStyledToggleButton.swift
//  DittoKit
//
//  Created by Ace Green on 1/19/21.
//

import UIKit

public protocol DKToggleButtonDelegate: class {
    func toggleButtonTapped(button: DKThemeStyledToggleButton)
}

public class DKThemeStyledToggleButton: UIButton {

    // Name of event to track when hitting button
    var eventName: String?

    // if the button stays selected use this to track the button selected event. eventName must be nil
    var checkboxSelectedEventName: String?

    // if the button stays selected use this to track the button unselected event. eventName must be nil
    var checkboxUnselectedEventName: String?

    // if the button exist in sections they should be listed here
    var eventSections: [String]?

    public weak var delegate: DKToggleButtonDelegate?

    /// When true, checkmark is displayed for the choice.
    public var isSelectedMarked: Bool = false {
        didSet {
            isHighlighted = isSelectedMarked
        }
    }

    // Programmatically: use the enum
    public var themedStyle: DKToggleButtonStyle = .defaultRadioButton {
        didSet {
            configureToggle()
        }
    }

    // IB: use the adapter
    @IBInspectable public var themedStyleAdapter: String {
        get {
            return self.themedStyle.rawValue
        }
        set(index) {
            self.themedStyle = DKToggleButtonStyle(rawValue: index) ?? .defaultRadioButton
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setStyle()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
    }

    public convenience init(title: String,
                            themedStyle: DKToggleButtonStyle = .defaultRadioButton,
                            delegate: DKToggleButtonDelegate) {
        self.init(frame: .zero)
        self.themedStyle = themedStyle
        self.delegate = delegate
        setStyle()
        setTitle(title, for: .normal)
    }

    public override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        accessibilityLabel = title
    }

    private func setStyle() {
        setLayout()
        configureToggle()
    }

    private func setLayout() {
        contentEdgeInsets = UIEdgeInsets.init(top: 12, left: 0, bottom: 12, right: 0)
        contentHorizontalAlignment = .leading
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        titleLabel?.font = themedStyle.type.font
        setTitleColor(themedStyle.type.textColor, for: .normal)
    }

    /// Convenience function for creating toggle cell views with a checkboxes.
    private func configureToggle() {
        setImage(themedStyle.type.icon, for: .normal)
        setImage(themedStyle.type.iconSelected, for: .highlighted)
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        if let delegate = delegate {
            delegate.toggleButtonTapped(button: self)
        } else { // If there is no delegate which implies the button does not belong to a group, select it
            isSelectedMarked = !isSelectedMarked
        }

        /// TRACK ANALYTICS
        if didTouchUpInside(touch: touches.first) {
            guard let name = eventName else {
                if let selected = checkboxSelectedEventName, let unselected = checkboxUnselectedEventName {
                    shouldTrack(event: isSelectedMarked ? selected : unselected, inSections: eventSections)
                }
                return
            }
            shouldTrack(event: name, inSections: eventSections)
        }
    }
}
