//
//  DKFormValidationError.swift
//  DittoKit
//
//  Copied from https://github.com/AudaxHealthInc/forms
//  Created by Avinash Dongarwar on 11/20/17.
//

import Foundation

/**
 Represents a validation error that occurred for a given element or for a form as a whole.

 - Note: This is an abstract base class.
 */
public struct DKFormValidationError {

    /**
     String copy related to error. Can be defined from consumer level.

     - Note: Default will be blank string.
     */
    public var errorDescription: String = ""

    public init(errorDescription: String) {
        self.errorDescription = errorDescription
    }
}
