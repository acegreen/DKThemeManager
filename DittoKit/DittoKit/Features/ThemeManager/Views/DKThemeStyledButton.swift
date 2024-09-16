//
//  DKThemeStyledButton.swift
//  DittoKit
//
//  Created by Ace Green on 1/8/21.
//

import UIKit

//Note: button type must be set as custom. This can only be done in the storyboard or by initializing as UIButton(type: .custom)
@IBDesignable
open class DKThemeStyledButton: UIButton {

    // Programmatically: use the enum
    public var themedStyle: DKThemeButtonStyle = .primaryButton {
        didSet {
            update()
        }
    }

    // IB: use the adapter
    @IBInspectable public var themedStyleAdapter: String {
        get {
            return self.themedStyle.rawValue
        }
        set(index) {
            self.themedStyle = DKThemeButtonStyle(rawValue: index) ?? .primaryButton
        }
    }

    public var alignment: UIControl.ContentHorizontalAlignment? {
        didSet {
            update()
        }
    }

    // Name of event to track when hitting button
    var eventName: String?

    // if the button exist in sections they should be listed here
    var eventSections: [String]?

    // private properties
    private var waitForAnimationToComplete = false
    private let pressAnimationDuration = 0.10
    private let releaseAnimationDuration = 0.30

    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?

    private func update() {
        setStyle(buttonStyle: themedStyle.type)
    }

    private func setStyle(buttonStyle: DKButton) {
        let unwrappedText = titleLabel?.text ?? ""
        setTitle(unwrappedText, for: .normal)
        titleLabel?.textAlignment = .left
        titleLabel?.font = buttonStyle.font
        setTitleColors(buttonStyle: buttonStyle)
        setBackgroundColor(buttonStyle: buttonStyle)
        setDimensions(buttonStyle: buttonStyle)
        setCornerRadius(buttonStyle: buttonStyle)
        setContentInset(buttonStyle: buttonStyle)
        adjustsImageWhenHighlighted = false
        accessibilityLabel = accessibilityLabel ?? unwrappedText
        titleLabel?.adjustsFontForContentSizeCategory = true
        guard let textAlignment = alignment else {
            contentHorizontalAlignment = .center
            return
        }
        contentHorizontalAlignment = textAlignment
    }

    public override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        accessibilityLabel = title
    }

    private func setTitleColors(buttonStyle: DKButton) {
        setTitleColor(buttonStyle.textColor, for: .normal)
        setTitleColor(buttonStyle.tappedTextColor, for: .highlighted)
        setTitleColor(buttonStyle.tappedTextColor, for: .selected)
    }

    private func setBackgroundColor(buttonStyle: DKButton) {
        backgroundColor = buttonStyle.backgroundColor
        layer.borderColor = buttonStyle.borderColor.cgColor
        layer.borderWidth = 1
    }

    private func setDimensions(buttonStyle: DKButton) {
        heightConstraint?.isActive = false
        heightConstraint = heightAnchor.constraint(equalToConstant: buttonStyle.height)
        heightConstraint?.isActive = true

        guard (buttonStyle is DKTheme.PrimaryButton || buttonStyle is DKTheme.SecondaryButton || buttonStyle is DKTheme.PrimaryAltButton),
              let superview = superview else { return }
        widthConstraint?.isActive = false
        widthConstraint = widthAnchor.constraint(equalTo: superview.widthAnchor)
        widthConstraint?.isActive = true
    }

    private func setCornerRadius(buttonStyle: DKButton) {
        cornerRadius = buttonStyle.cornerRadius
    }

    private func setContentInset(buttonStyle: DKButton) {
        contentEdgeInsets = buttonStyle.contentInsets
        setNeedsLayout()
    }

    public override func setAttributedTitle(_ title: NSAttributedString?, for state: UIControl.State) {
        super.setAttributedTitle(title, for: state)
        accessibilityLabel = title?.string
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        waitForAnimationToComplete = true
        isUserInteractionEnabled = false
        pressAnimation()
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        releaseAnimation()

        /// TRACK ANALYTICS
        if didTouchUpInside(touch: touches.first) {
            guard let name = eventName else { return }
            shouldTrack(event: name, inSections: eventSections)
        }
    }

    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        releaseAnimation(withSendAction: false)
    }

    // In case touchesEnded is not get called (Press and Hold and Button action set as touchDown) then need to do release animation
    open override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        if newWindow == nil {
            setDefaultLayerAnimationState()
            if waitForAnimationToComplete {
                isUserInteractionEnabled = true
            }
            waitForAnimationToComplete = false
        }
    }
}

typealias DKThemeStyledButtonAnimation = DKThemeStyledButton
extension DKThemeStyledButtonAnimation {
    // Button Animation State
    private enum ButtonAnimationState {
        case press
        case release
    }

    /**
     Get border Color animation  on button press and release state.
     
     - Parameters:
     - animationState: Parameter is used to check button press and release state.
     */
    private func getBorderColorAnimation(for animationState: ButtonAnimationState) -> CABasicAnimation {
        let colorAnimation = CABasicAnimation(keyPath: "borderColor")
        switch animationState {
        case .press:
            colorAnimation.fromValue = themedStyle.type.borderColor.cgColor
            colorAnimation.toValue = themedStyle.type.tappedBorderColor.cgColor
            layer.borderColor = themedStyle.type.tappedBorderColor.cgColor
        case .release:
            colorAnimation.fromValue = themedStyle.type.tappedBorderColor.cgColor
            colorAnimation.toValue = themedStyle.type.borderColor.cgColor
            layer.borderColor = themedStyle.type.borderColor.cgColor
        }
        return colorAnimation
    }

    /**
     Get border Width animation  on button press and release state. For primary button no need of boder Animation.
     
     - Parameters:
     - animationState: Parameter is used to check button press and release state.
     */
    private func getBorderWidthAnimation(for animationState: ButtonAnimationState) -> CABasicAnimation? {
        let widthAnimation = CABasicAnimation(keyPath: "borderWidth")
        switch animationState {
        case .press:
            widthAnimation.fromValue = 1
            widthAnimation.toValue = 2
            layer.borderWidth = 2
        case .release:
            widthAnimation.fromValue = 2
            widthAnimation.toValue = 1
            layer.borderWidth = 1
        }
        return widthAnimation
    }

    /**
     Get background color animation on button press and release state. For primary button no need of boder Animation.
     
     - Parameters:
     - animationState: Parameter is used to check button press and release state.
     */
    private func getBackgroundAnimation(for animationState: ButtonAnimationState) -> CABasicAnimation {
        let backgroundColorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        switch animationState {
        case .press:
            backgroundColorAnimation.fromValue = themedStyle.type.backgroundColor.cgColor
            backgroundColorAnimation.toValue = themedStyle.type.tappedBackgroundColor.cgColor
            layer.backgroundColor = themedStyle.type.tappedBackgroundColor.cgColor
        case .release:
            backgroundColorAnimation.fromValue = themedStyle.type.tappedBackgroundColor.cgColor
            backgroundColorAnimation.toValue = themedStyle.type.backgroundColor.cgColor
            layer.backgroundColor = themedStyle.type.backgroundColor.cgColor
        }
        return backgroundColorAnimation
    }

    /**
     Get Scale animation on button press and release state. For primary button no need of boder Animation.
     
     - Parameters:
     - animationState: Parameter is used to check button press and release state.
     */
    private func getScaleAnimation(for animationState: ButtonAnimationState) -> CABasicAnimation {
        let transform = CABasicAnimation(keyPath: "transform.scale")
        switch animationState {
        case .press:
            transform.fromValue = 1
            transform.toValue = 0.95
            transform.isRemovedOnCompletion = false
            layer.transform = CATransform3DMakeScale(0.95, 0.95, 0.95)
        case .release:
            transform.fromValue = 0.95
            transform.toValue = 1
            transform.isRemovedOnCompletion = false
            layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
        }
        return transform
    }
}

typealias ApplyDKThemeStyledButtonAnimation = DKThemeStyledButton
extension ApplyDKThemeStyledButtonAnimation {
    private func setDefaultLayerAnimationState() {
        layer.borderWidth = 1
        layer.borderColor = themedStyle.type.borderColor.cgColor
        layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
        setTitleColor(themedStyle.type.textColor, for: .normal)
        backgroundColor = themedStyle.type.backgroundColor
    }
    /**
     Press Animation apply  animation on border color, border width, background color, and scale.
     */
    private func pressAnimation() {
        setTitleColor(themedStyle.type.tappedTextColor, for: .normal)
        CATransaction.begin()
        CATransaction.setAnimationDuration(pressAnimationDuration)
        let allLayerAnimation = CAAnimationGroup()
        allLayerAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        allLayerAnimation.animations = []
        CATransaction.setCompletionBlock({ [weak self] in
            self?.layer.removeAllAnimations()
            self?.layer.borderWidth = 2
            self?.layer.borderColor = self?.themedStyle.type.tappedBorderColor.cgColor
            self?.layer.transform = CATransform3DMakeScale(0.95, 0.95, 0.95)
            self?.backgroundColor = self?.themedStyle.type.tappedBackgroundColor
        })

        allLayerAnimation.animations?.append(getBorderColorAnimation(for: .press))
        if let borderWidthAnimation = getBorderWidthAnimation(for: .press) {
            allLayerAnimation.animations?.append(borderWidthAnimation)
        }
        allLayerAnimation.animations?.append(getBackgroundAnimation(for: .press))
        allLayerAnimation.animations?.append(getScaleAnimation(for: .press))

        layer.add(allLayerAnimation, forKey: "press")
        CATransaction.commit()
    }

    /**
     Release Animation apply  animation on border color, border width, background color, and scale.
     callback
     
     - Parameters:
     - withSendAction: send an touchInside action or not
     */
     private func releaseAnimation(withSendAction action: Bool = true) {
        isHighlighted = false
        CATransaction.begin()
        CATransaction.setAnimationDuration(releaseAnimationDuration)
        let allLayerAnimation = CAAnimationGroup()
        allLayerAnimation.animations = []
        allLayerAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        CATransaction.setCompletionBlock({ [weak self] in
            self?.isUserInteractionEnabled = true
            self?.waitForAnimationToComplete = false
            self?.setDefaultLayerAnimationState()
            self?.layer.removeAllAnimations()
            // hardcoded touchUpInside to send action. All button animation need to implement touchUpInside control event action.
            // reason: super.touchesEnded not work inside Animation
            if action == true {
                self?.sendActions(for: .touchUpInside)
            }
        })

        allLayerAnimation.animations?.append(getBorderColorAnimation(for: .release))
        if let borderWidthAnimation = getBorderWidthAnimation(for: .release) {
            allLayerAnimation.animations?.append(borderWidthAnimation)
        }
        allLayerAnimation.animations?.append(getBackgroundAnimation(for: .release))
        allLayerAnimation.animations?.append(getScaleAnimation(for: .release))

        layer.add(allLayerAnimation, forKey: "release")
        CATransaction.commit()
    }
}
