//
//  DKForm+Extensions.swift
//  DittoKit
//
//  Copied from https://github.com/AudaxHealthInc/forms
//  Created by Avinash Dongarwar on 11/20/17.
//

import UIKit

extension DKForm: DKFormElementDelegate {

    public func formElement(_ element: DKFormElement, didUpdate validationError: DKFormValidationError?) {
        // validation was updated for an element. update our validation result.
        guard let currentValidationResult = currentValidationResult  else { return }
        currentValidationResult.setValidationError(validationError, element.identifier)
        currentValidationResult.formError = formValidationError
        formDelegate?.form(self, didChange: currentValidationResult)
    }
    // The base class here is empty, but subclasses can override to do additional validations that are not specific
    // to a single element. e.g. must fill in 2 out of 5 fields, values must add to 10, etc.
    var formValidationError: DKFormValidationError? {
        return nil
    }
}

// MARK: UITextFieldDelegate
extension DKForm: UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}

extension DKForm {

    @objc func previousItem(_ sender: Any) {
        guard let  currentElement = currentResponderElement else { return }

        if let arrayOfResponders = currentElement.respondersForInput,
            let currentResponder = currentElement.currentResponder, arrayOfResponders.count > 1,
            let index = arrayOfResponders.firstIndex(of: currentResponder), index > 0 {
            currentElement.responderBecomeFirstResponder(at: index - 1)
            return
        }
        guard let previousElement = nextElementAfterElement(currentElement, .directionUp) else { return }
        previousElement.elementBecomeFirstResponder(with: .directionUp)
        scrollElementToVisible(previousElement, true)
    }

    @objc func nextItem(_ sender: Any) {
        guard let  currentElement = currentResponderElement else { return }
        if let arrayOfResponders = currentElement.respondersForInput,
            let currentResponder = currentElement.currentResponder, arrayOfResponders.count > 1,
            let index = arrayOfResponders.firstIndex(of: currentResponder), index <  arrayOfResponders.count - 1 {
            currentElement.responderBecomeFirstResponder(at: index + 1)
            return
        }
        guard let nextElement = nextElementAfterElement(currentElement, .directionDown) else { return }
        nextElement.elementBecomeFirstResponder(with: .directionDown)
        scrollElementToVisible(nextElement, true)
    }

    func nextElementAfterElement(_ element: DKFormElement, _ inDirection: DKFormCycleDirection) -> DKFormElement? {
        guard var newIndex = elements.firstIndex(of: element) else { return nil }
        newIndex = inDirection == .directionDown ? newIndex + 1 : newIndex - 1
        guard newIndex >= 0, newIndex < elements.count else { return nil }
        let nextElement = elements[newIndex]
        guard nextElement.elementCanBecomeFirstResponder else {
            return self.nextElementAfterElement(nextElement, inDirection)
        }
        return nextElement
    }

    public func removeValidationError(_ elementIdentifier: String) {
        currentValidationResult?.mutableElementErrors.removeValue(forKey: elementIdentifier)
    }
}
