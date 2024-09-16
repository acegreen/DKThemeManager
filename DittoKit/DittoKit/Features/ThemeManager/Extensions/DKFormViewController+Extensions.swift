//
//  DKFormViewController+Extensions.swift
//  DittoKit
//
//  Created by Ace Green on 4/28/21.
//

import UIKit

public extension DKFormViewController {

    func getThemeStyledFieldFor(_ identifier: String) -> DKThemeStyledTextFormField? {
        guard let field = formView.elements.first(where: { $0.identifier == identifier }) as? DKThemeStyledTextFormField else { return nil }
        return field
    }
    // Getting last editing field. If there is only one field blank, that's last editing field.
    func isLastThemeStyledFieldEditing(_ identifier: String) -> Bool {
        guard let fields = formView.elements as? [DKThemeStyledTextFormField] else { return false }
        return !fields.contains { $0.identifier != identifier && $0.inputField.text == "" }
    }

    // Getting if individual field has  error
    func fieldHasError (_ textField: DKThemeStyledTextFormField) -> Bool {
        return formView.currentValidationResult?.mutableElementErrors[textField.identifier] != nil
    }
}
