//
//  DKFormNextViewController.swift
//  DittoKit
//
//  Copied from https://github.com/AudaxHealthInc/forms
//  Created by Avinash Dongarwar on 11/20/17.
//

import UIKit

/**
 `UIViewController` instance managing -

 * Laying out and applying relevant constraints to `DKFormNextButton` instance.
 */
open class DKFormNextViewController: UIViewController {

    public var nextButton = DKFormNextButton(frame: CGRect.zero)
    var nextButtonBottomConstraint: NSLayoutConstraint?
    var nextButtonHeightShowConstraint: NSLayoutConstraint?
    var nextButtonHeightHideConstraint: NSLayoutConstraint?
    private let nextButtonHeight: CGFloat = 50.0

    open override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.isEnabled = true
        nextButton.clipsToBounds = true
        nextButton.title = NSLocalizedString("Next", comment: "")
        view.addSubview(nextButton)

        nextButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true

        nextButtonBottomConstraint = view.bottomAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 0.0)
        nextButtonBottomConstraint?.isActive = true

        nextButtonHeightShowConstraint = NSLayoutConstraint(item: nextButton, attribute: .height,
                                                        relatedBy: .equal, toItem: nil,
                                                        attribute: .height, multiplier: 1.0,
                                                        constant: nextButtonHeight)

        nextButtonHeightHideConstraint = NSLayoutConstraint(item: nextButton, attribute: .height,
                                                            relatedBy: .equal, toItem: nil,
                                                            attribute: .height, multiplier: 1.0,
                                                            constant: 0)

    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.bringSubviewToFront(nextButton)
    }
}
