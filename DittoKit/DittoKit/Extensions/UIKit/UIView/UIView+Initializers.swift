//
//  UIView+Initializers.swift
//  DittoKit
//
//  Created by Ace Green on 4/6/21.
//

import UIKit

public extension UIView {

    class func loadViewFromNib(named nibName: String, owner: AnyObject, bundle: Bundle?) -> UIView {
        let nib = UINib(nibName: nibName, bundle: bundle != nil ? bundle : Bundle(for: type(of: owner)))

        guard let view = nib.instantiate(withOwner: owner, options: nil)[0] as? UIView else {
            return UIView()
        }
        return view
    }

    @discardableResult class func setupNib(named nibName: String, superview: UIView, bundle: Bundle? = nil) -> UIView {
        let view = UIView.loadViewFromNib(named: nibName, owner: superview, bundle: bundle)

        // Adding custom subview on top of our view (over any custom drawing > see note below)
        superview.addSubview(view)

        // Set up the constraints such that the view is set up to match the superview
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true

        return view
    }
}
