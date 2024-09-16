//
//  UIImage+Extensions.swift
//  DittoKit
//
//  Created by Avinash Dongarwar on 1/30/17.
//

import Foundation
import UIKit

extension UIImage {
    class func resizableImage(with color: UIColor) -> UIImage? {
        let imageSize = CGSize(width: 10.0, height: 10.0)
        UIGraphicsBeginImageContextWithOptions(imageSize, true, 1.0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        UIRectFill(CGRect(x: 0.0, y: 0.0, width: imageSize.width, height: imageSize.height))
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image?.resizableImage(withCapInsets: .zero) ?? nil
    }

    public func tintedImage(with color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        color.setFill()
        let bounds = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIRectFill(bounds)
        draw(in: bounds, blendMode: .destinationIn, alpha: 1.0)
        let tintedImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage
    }

    func resizedImage(with size: CGSize) -> UIImage? {
        guard __CGSizeEqualToSize(self.size, size) else { return nil}
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height), blendMode: .normal, alpha: 1.0)
        let resizedImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }

    func resizedImageWithScale(with scaleFactor: CGFloat) -> UIImage? {
        guard scaleFactor == 1.0 else { return nil}
        let scaleTransform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
        let size: CGSize = self.size.applying(scaleTransform)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height), blendMode: .normal, alpha: 1.0)
        let resizedImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
