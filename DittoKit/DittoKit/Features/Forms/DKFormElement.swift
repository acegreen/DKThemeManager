//
//  DKFormElement.swift
//  DittoKit
//
//  Copied from https://github.com/AudaxHealthInc/forms
//  Created by Avinash Dongarwar on 11/20/17.
//

import UIKit

/**
 Sequence of cursor focuses when left/right control on Keyboard accessory view is used.

 - down: Top to bottom direction.
 - up: Bottom to top direction.
 */
public enum DKFormCycleDirection {
    /// Top to bottom direction.
    case directionDown
    /// Bottom to top direction.
    case directionUp
}

/**
 Block for providing additional validations on an instance of `DKFormElement`.

 - Parameter identifier: The identifier of the element to validate.
 - Parameter value: The value to validate.
 
 - Returns: The error that resulted from the validation, or *nil* if the value is valid.
 */
public typealias DKFormElementValidationBlock = (_ identifier: String, _ value: Any?) -> DKFormValidationError?

/// Delegate protocol for DKFormElement.
public protocol DKFormElementDelegate: class {
    /**
     Informs the receiver that the element's validation state has been updated.
     @param element
     - Parameter element: The element for which message being casted.
     - Parameter validationError: The error that resulted from the validation, or *nil* if the value is valid.
     */
    func formElement(_ element: DKFormElement, didUpdate validationError: DKFormValidationError?)
}

/**
 DKForm elements provide a view, which can optionally accept user input.

 - Note: This is an abstract base class.
 */
open class DKFormElement: UIView {

    /// Delegate for responding to events from the form element.
    open weak var delegate: DKFormElementDelegate?
    /// The block that internally gets checked by subclasses.
    public var internalValidationBlock: DKFormElementValidationBlock?
    /// A unique identifier for the element.
    @IBInspectable public var identifier: String = ""

    public var currentError: DKFormValidationError?

    /**
     Responder object in current form element, use only when there is one item.
     
     - Note: Needs to be overridden by child classes.
     */
    open var responderForInput: UIResponder? {
        return nil
    }

    /**
     Responder objects in current form element, use only when there are more one item.

     - Note: Needs to be overridden by child classes.
     */
    open var respondersForInput: [UIResponder]? {
        guard let responder = responderForInput else { return nil }
        return [responder]
    }

    /**
     Current foucsed responder object.

     - Note: Needs to be overridden by child classes.
     */

    var currentResponder: UIResponder? {
        guard let arrayOfResponders = respondersForInput,
            let currentResponder = arrayOfResponders.filter({ $0.isFirstResponder }).first  else { return nil }
        return currentResponder
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    public convenience init(identifier: String) {
        self.init()
        self.identifier = identifier
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public func update(with error: DKFormValidationError?) {
        // subclasses will override?
        self.currentError = error
    }

    open func elementBecomeFirstResponder(with direction: DKFormCycleDirection) {
        // no op.
    }

    open var elementCanBecomeFirstResponder: Bool {
        return false
    }

    open func responderBecomeFirstResponder(at index: Int) {
        respondersForInput?[index].becomeFirstResponder()
    }
}
