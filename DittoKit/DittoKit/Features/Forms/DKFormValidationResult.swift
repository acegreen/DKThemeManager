//
//  DKFormValidationResult.swift
//  DittoKit
//
//  Copied from https://github.com/AudaxHealthInc/forms
//  Created by Avinash Dongarwar on 11/20/17.
//

import Foundation

/// `DKFormElementValidationResult` keeps track of validation results of a form element.
open class DKFormValidationResult {
    /// `DKFormData` instance containing all data in a `DKForm` instance.
    var data: DKFormData?
    /// `DKFormValidationError` instance containing applicable errors in a `DKForm` instance.
    var formError: DKFormValidationError?
    public var mutableElementErrors: [String: DKFormValidationError]

    init() {
        mutableElementErrors = [String: DKFormValidationError]()
    }

    var isValid: Bool {
        return mutableElementErrors.count == 0 && formError == nil
    }

    func errorForElementWithIdentifier(_ elementIdentifier: String) -> DKFormValidationError? {
        return mutableElementErrors[elementIdentifier] ?? nil
    }

    func setValidationError(_ error: DKFormValidationError?, _ elementIdentifier: String?) {
        guard let elementIdentifier = elementIdentifier else {
            return
        }
        guard let error = error else {
            mutableElementErrors.removeValue(forKey: elementIdentifier)
            return
        }
        mutableElementErrors[elementIdentifier] = error
    }
}
