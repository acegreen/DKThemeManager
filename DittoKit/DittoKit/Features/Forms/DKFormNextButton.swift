//
//  DKFormNextButton.swift
//  DittoKit
//
//  Copied from https://github.com/AudaxHealthInc/forms
//  Created by Avinash Dongarwar on 11/20/17.
//

import UIKit

/// A Configurable UIButton class.
@IBDesignable
open class DKFormNextButton: UIButton {

    public var arrowView = UIImageView(frame: CGRect.zero)

    /// Set title color of UIButton in normal state.
    public var textColorEnabledState = UIColor.white {
        didSet {
            setTitleColor(textColorEnabledState, for: .normal)
        }
    }

    /// Set title color of UIButton in disabled state.
    var textColorDisabledState = UIColor.lightGray {
        didSet {
            setTitleColor(textColorDisabledState, for: .disabled)
        }
    }

    /// Set title of UIButton in all states.
    var title = NSLocalizedString("Next", comment: "") {
        didSet {
            setTitle(title, for: .normal)
        }
    }

    /// Set font of UIButton title.
    var titleFont = UIFont(name: "HelveticaNeue-Light", size: 22.0) {
        didSet {
            titleLabel?.font = titleFont
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        nextButtonSetup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nextButtonSetup()
    }

    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        nextButtonSetup()
    }

    private func nextButtonSetup() {
        arrowView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(arrowView)
        arrowView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0.0).isActive = true
        rightAnchor.constraint(equalTo: arrowView.rightAnchor, constant: 35.0).isActive = true
        // Default Properties
        setTitle(NSLocalizedString("Next", comment: ""), for: .normal)
        titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 22.0)
    }
}
