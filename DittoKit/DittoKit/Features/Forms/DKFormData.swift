//
//  DKFormData.swift
//  DittoKit
//
//  Copied from https://github.com/AudaxHealthInc/forms
//  Created by Avinash Dongarwar on 11/20/17.
//

import Foundation

/**
 DKFormData helps querying and setting values of form elements in a `DKForm` instance.

 - Note: This is an abstract base class.
 */
public struct DKFormData {

    public init() {}

    /// Dictionary to record values against identifier strings of form elements.
    private var mutableElementValues = [String: Any]()

    /**
     Returns value for a form element.
     
     - Parameters:
     - identifier: Identifier of the form  element.

     - Returns: A value for form element in `mutableElementValues` dictionary,  `identifier` used as key.
     */
    func valueForElementWithIdentifier(identifier: String) -> Any? {
        return mutableElementValues[identifier] ?? nil
    }

    /**
     Sets value against form element's identifier string as key in `mutableElementValues` dictionary.

     - Parameters:
     - identifier: Identifier of the form  element.
     - value: Value related to the form element with given identifier.
     */
    mutating func setValue(_ value: Any?, _ identifier: String) {
        guard let value = value  else {
            mutableElementValues.removeValue(forKey: identifier)
            return
        }
        mutableElementValues[identifier] = value
    }
}
