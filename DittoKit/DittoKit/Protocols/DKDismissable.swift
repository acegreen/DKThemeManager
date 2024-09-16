//
//  DKDismissable.swift
//  DittoKit
//
//  Created by Ace Green on 4/6/21.
//

import Foundation
import UIKit

fileprivate extension UIViewController {
    @objc func _dismissButtonAction(_ sender: Any) {
        if let dimissable = self as? DKDismissable {
            dimissable.dismissButtonAction(sender)
        }
    }
}

public extension Selector {
    static let dismiss =
        #selector(UIViewController._dismissButtonAction(_:))
}

public protocol DKDismissable: UIViewController {
    func addDismissButton()
    func dismissButtonAction(_ sender: Any?)
}

public extension DKDismissable where Self: UIViewController {
    func addDismissButton() {
        let barButtonItem = UIBarButtonItem(image: DKRDSIcons.close.image, style: .plain, target: self, action: .dismiss)
        barButtonItem.accessibilityLabel = NSLocalizedString("Close", comment: "")
        navigationItem.leftBarButtonItem = barButtonItem
    }

    func dismissButtonAction(_ sender: Any?) {
        dismiss(animated: true)
    }
}
