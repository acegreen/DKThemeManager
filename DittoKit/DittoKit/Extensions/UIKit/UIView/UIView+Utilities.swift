//
//  UIView+Utilities.swift
//  DittoKit
//
//  Created by Ace Green on 4/6/21.
//

import UIKit

private var embeddedViewHandle: UInt8 = 0

public extension UIView {

    // MARK: View Loading

    class func forDefaultNib<View: UIView>(_ viewClass: View.Type) -> View {
        let nibObjects = Bundle(for: viewClass).loadNibNamed(String(describing: viewClass), owner: self, options: nil)
        guard let view = nibObjects?.first as? View else {
            fatalError("Could Not Load Nib from Bundle for View: " + String(describing: viewClass))
        }
        return view
    }

    // MARK: - Embedded View - Used In Donations and Missions

    @IBOutlet var embeddedView: UIView? {
        get {
            return objc_getAssociatedObject(self, &embeddedViewHandle) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &embeddedViewHandle, newValue as UIView?,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    // AG: Do not resolve this as Engage (objc requires this property to be open)
    @objc var defaultNib: UINib? {
        return nil
    }

    @objc func loadEmbeddedView() {
        let nib = defaultNib ?? UINib(nibName: String(describing: type(of: self)), bundle: Bundle(for: type(of: self)))
        nib.instantiate(withOwner: self, options: nil)
        if let newView = embeddedView {
            newView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(newView)
            newView.frame = bounds
            newView.center = self.innerCenter
            layoutIfNeeded()
        }
    }

    // MARK: - Xib Setup - Used In Challenges & RallyAgeView

    // AG: Do not resolve this as Engage (objc requires this property to be open)
    @objc func xibSetup() {
        // We do a check to prevent infinite recursion. This check shouldn't be necessary during
        // runtime, however Interface Builder will recurse during storyboard display and generate
        // errors without this guard.
        guard self.subviews.isEmpty else { return }

        let nib = defaultNib ?? UINib(nibName: String(describing: type(of: self)),
                                      bundle: Bundle(for: type(of: self)))
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        view.frame = bounds
        addSubview(view)
    }
}

// MARK: - Round Corners

public extension UIView {

    /// Round selected corners on a UIView
    /// Use it like this: myView.roundCorners([.topLeft, .bottomLeft], radius: 10)
    ///
    /// - Parameters:
    ///   - corners: array of corners
    ///   - radius: in pixels
    func roundedCorners(radius: CGFloat = 5,
                        color: UIColor? = nil,
                        width: CGFloat = 2.0,
                        corners: UIRectCorner = .allCorners) {
        layer.cornerRadius = radius
        layer.masksToBounds = true

        if let color = color {
            layer.borderColor = color.cgColor
            layer.borderWidth = width
        }
        layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
    }
}

public extension UIView {

    enum Scale: CGFloat {
        case half = 0.5
        case full = 1
    }

    var innerCenter: CGPoint {
        return CGPoint(x: self.bounds.midX, y: self.bounds.midY)
    }

    func rect(width: Scale = .half, height: CGFloat) -> CGSize {
        return CGSize(width: frame.width * width.rawValue, height: height)
    }
}

// MARK: - IBInspectable Corner radius, borderWidth, borderColor

@IBDesignable
public extension UIView {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

@IBDesignable
public extension UIView {

    @IBInspectable var shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let uiColor = newValue else { return }
            layer.shadowColor = uiColor.cgColor
        }
    }

    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
}
