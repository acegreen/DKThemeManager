//
//  DKFormElementValidationResult.swift
//  DittoKit
//
//  Copied from https://github.com/AudaxHealthInc/forms
//  Created by Avinash Dongarwar on 11/20/17.
//

import Foundation

/**
 `DKFormElementValidationResult` keeps track of validation results of a form element.

 - Note: This is an abstract base class.
 */
public struct DKFormElementValidationResult {

    /// Identifier of the element being validated.
    var elementIdentifier: String?

    /// Value of the form element being validated.
    var value: Any?

    /// Array of the errors i.e. `DKFormValidationError` instances
    private var mutableErrors = [DKFormValidationError]()

    public init() {}

    // MARK: Property accessors
    var validationErrors: [DKFormValidationError] {
        return self.mutableErrors
    }

    var isValid: Bool {
        return self.validationErrors.count == 0
    }

    // MARK: - Public interface
    init(identifier: String, value: Any) {
        self.elementIdentifier = identifier
        self.value = value
    }

    mutating func addError(_ error: DKFormValidationError) {
        self.mutableErrors.append(error)
    }
}
