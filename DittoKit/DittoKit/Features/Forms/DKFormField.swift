//
//  DKFormField.swift
//  DittoKit
//
//  Copied from https://github.com/AudaxHealthInc/forms
//  Created by Avinash Dongarwar on 11/20/17.
//

import UIKit

open class DKFormField: DKFormElement {

    // MARK: Property accessors
    /**
     Value of the form element, override and manipulate from subclass.

     - Note: Needs to be overridden by child classes.
     */
    open var elementValue: Any? {
        get {
            assertionFailure("WARNING: Function: \(#function), line: \(#line) must be overriden.")
            return nil
        }
        set(newValue) {
            print(newValue ?? "No new value")
            assertionFailure("WARNING: Function: \(#function), line: \(#line) must be overriden.")
        }
    }

    // MARK: Public interface
    func validate(_ value: Any) -> DKFormElementValidationResult {
        return DKFormElementValidationResult(identifier: self.identifier, value: value)
    }
}
