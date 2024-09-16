//
//  UIView+Extensions.swift
//  DittoKit
//
//  Created by Ace Green on 4/6/21.
//

import UIKit

public extension UIView {

    /// Helper method to find and return a view of a specific type if it exists as superview in the view's hierarchy.
    ///
    /// - Parameter ofType: The type of the superview.
    /// - Returns: A view of the specified type if found, or nil.
    func superview<T>(ofType: T.Type) -> T? {
        if let superview = self.superview {
            if let foundView = superview as? T {
                return foundView
            } else {
                return superview.superview(ofType: T.self)
            }
        } else {
            return nil
        }
    }

    func didTouchUpInside(touch: UITouch?) -> Bool {
        guard let tap = touch else { return false }
        let xValue = tap.location(in: self).x
        let yValue = tap.location(in: self).y
        if xValue >= 0, xValue <= frame.size.width, yValue >= 0, yValue <= frame.size.height {
            return true
        } else {
            return false
        }
    }
}
