//
//  DKFormFields.swift
//  DittoKit
//
//  Copied from https://github.com/AudaxHealthInc/forms
//  Created by Avinash Dongarwar on 11/20/17.
//

import UIKit

public protocol DKFormFields: CaseIterable {
    var identifier: String { get }
    var fieldLabelInfo: String { get }
    var errorDescriptions: String { get }
}

public protocol DKFormFieldValidationProtocol: class {
    var hideConstraint: NSLayoutConstraint? { get set }
    func validate()
    var fieldIsHidden: Bool { get }
}

public extension DKFormFieldValidationProtocol {
    var fieldIsHidden: Bool {
        return hideConstraint?.isActive ?? false
    }
}
