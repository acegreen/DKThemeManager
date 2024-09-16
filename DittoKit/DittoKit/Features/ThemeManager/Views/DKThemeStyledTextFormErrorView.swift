//
//  DKThemeStyledTextFormErrorView.swift
//  DittoKit
//
//  Created by Ace Green on 1/8/21.
//

import UIKit

@IBDesignable
public class DKThemeStyledTextFormErrorView: UIView {

    @IBOutlet weak var errorLabel: DKThemeStyledLabel!
    @IBOutlet weak var errorImageView: UIImageView!

    public var errorImage: UIImage? = DKRDSIcons.alert.image?.tintedImage(with: DKThemeManager.shared.current.colors.feedbackDangerDark) {
        didSet {
            errorImageView.image = errorImage
        }
    }

    public var text: String = "" {
        didSet {
            errorLabel.text = text
            accessibilityLabel = text
            setNeedsUpdateConstraints()
        }
    }

    public init(withErrorMessage text: String) {
        super.init(frame: CGRect.zero)
        commonInit()
        errorLabel.text = text
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        commonInit()
    }

    private func commonInit() {
        UIView.setupNib(named: String(describing: DKThemeStyledTextFormErrorView.self),
                        superview: self,
                        bundle: DKBundleHelper.bundle(named: DittoKit.bundleName))
        errorImageView.image = errorImage
        isAccessibilityElement = true
    }
}
