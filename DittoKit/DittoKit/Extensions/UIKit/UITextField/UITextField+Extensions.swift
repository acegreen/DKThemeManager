//
//  UITextField+Extensions.swift
//  Ditto-iOS
//
//  Created by Ace Green on 4/6/21.
//

import UIKit

public extension UITextField {
    func addDoneButton(fromSender sender: Any, selector: Selector? = nil) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done,
                                            target: selector != nil ? sender : self,
                                            action: selector ?? #selector(self.endEditing(_:)))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        inputAccessoryView = keyboardToolbar
    }
}
