//
//  DKForm.swift
//  DittoKit
//
//  Copied from https://github.com/AudaxHealthInc/forms
//  Created by Avinash Dongarwar on 11/20/17.
//

import UIKit

/**
 Positioning of all form elements' container view.

 - full: Alignment of form elements starts from top of container view.
 - centered: DKForm elements will be placed at center of container view.
 */
public enum DKFormScreenType {
    /// Alignment of form elements starts from top of container view.
    case full
    /// DKForm elements will be placed at center of container view.
    case centered
}

/// Facilitiate casting of events in DKForm instance.
public protocol DKFormDelegate: class {
    /**
     Informs receiver of validation result changes in form of `DKFormValidationResult` instance.
     - Warning: This will be called on delegate for validation result change of every `DKFormElement` instance.
     - Parameter form: `DKForm` instance for which result being notified for.
     - Parameter result: `DKFormValidationResult` instance containing `DKFormValidationError` instances if applicable.
     */
    func form(_ form: DKForm, didChange result: DKFormValidationResult)
}

/// DKForm provide a scroll view, which renders and lays out all `DKFormElement` instances.
open class DKForm: UIScrollView {

    /// `DKFormDelegate` instance.
    public weak var formDelegate: DKFormDelegate?
    /// Determines whether form position is centered or full-screen
    public var screenMode: DKFormScreenType?
    /**
     `DKFormElement` instances to be rendered on **DKForm**.
     
     ### Usage Example: ###
     ````
     var formView = DKForm(frame: .zero)
     let formElements = [DKFormElement(frame: .zero), DKFormElement(frame: .zero)]
     formView.elements = elements
     ````

     * Whenever set, all existing `DKFormElement` instances will be removed.
     * Ordering of fields/subviews will be exaclty as ordering of `DKFormElement` instances in this array.
     */
    public var elements = [DKFormElement]() {
        willSet {
            for view in self.elements {
                view.delegate = nil
                view.removeFromSuperview()
            }
        }
        didSet {
            for view in self.elements {
                if let responders = view.respondersForInput as? [UITextField], respondersCount > 1 {
                    responders.forEach({ $0.inputAccessoryView = focusToolbar })
                }
                view.delegate = self
                view.translatesAutoresizingMaskIntoConstraints = false
                containerView?.addSubview(view)
            }
            setNeedsUpdateConstraints()
        }
    }

    /**
     A view that is laid out at the top of the element views. You must manage the constraints of this view.

     - Note: Whenever set, existing headerView will be removed.
     */

    public var headerView: UIView? {
        willSet {
            headerView?.removeFromSuperview()
        }
        didSet {
            guard let headerView = headerView else { return }
            headerView.translatesAutoresizingMaskIntoConstraints = false
            containerView?.addSubview(headerView)
            setNeedsUpdateConstraints()
        }
    }

    /**
     A view that is laid out at the bottom of the element views. You must manage the constraints of this view.

     - Note: Whenever set, existing footerView will be removed.
     */
    public var footerView: UIView? {
        willSet {
            footerView?.removeFromSuperview()
        }
        didSet {
            guard let footerView = footerView else { return }
            footerView.translatesAutoresizingMaskIntoConstraints = false
            containerView?.addSubview(footerView)
            setNeedsUpdateConstraints()
        }
    }
    /// Keyboard accessory view.
    public var focusToolbar = UIToolbar()
    /// Current validation result possibly containing multiple DKFormValidationErrors
    public var currentValidationResult: DKFormValidationResult?
    /// The content size inset to adjust the size of the content.
    var bottomContentSizeInset: CGFloat? {
        didSet {
            guard let bottomContentSizeInset = bottomContentSizeInset  else { return }
            equalHeightConstraint?.constant = bottomContentSizeInset
        }
    }
    /// Container view for the form's header, footer, and elements.
    fileprivate var containerView: UIView?
    /// The container view used to force a content size of at least the frame.
    fileprivate var outerContainerView: UIView?
    /// The equal height constraint that we can adjust to adjust the content size.
    fileprivate var equalHeightConstraint: NSLayoutConstraint?
    /// The previous constraints created by the form. Useful for removing all previous constraints.
    fileprivate var previousConstraints = [NSLayoutConstraint]()

    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    private func setUp() {
        self.outerContainerView = UIView()
        self.outerContainerView?.translatesAutoresizingMaskIntoConstraints = false
        self.containerView = UIView()
        self.containerView?.translatesAutoresizingMaskIntoConstraints = false
        self.currentValidationResult = DKFormValidationResult()
        self.focusToolbar.sizeToFit()
        self.focusToolbar.isTranslucent = false

        let previousImage = DKRDSIcons.chevronLeft.image
        let nextImage = DKRDSIcons.chevronRight.image

        let previousItem = UIBarButtonItem(image: previousImage, style: .plain,
                                           target: self, action: #selector(self.previousItem))
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        space.width = 20.0

        let nextItem = UIBarButtonItem(image: nextImage, style: .plain, target: self, action: #selector(self.nextItem))
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done,
                                            target: self, action: #selector(self.doneButtonPressed))
        if let tintColor = self.focusToolbar.tintColor {
            doneBarButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: tintColor],
                                                 for: .normal)
        }

        self.focusToolbar.items = [previousItem, space, nextItem, flexBarButton, doneBarButton]

        guard let containerView = self.containerView   else {
            fatalError("containerView must exist!")
        }
        self.outerContainerView?.addSubview(containerView)
        guard let outerContainerView = self.outerContainerView   else {
            fatalError("outerContainerView must exist!")
        }
        self.addSubview(outerContainerView)
    }

    // MARK: Responder chain
    public var currentResponderElement: DKFormElement? {
        guard let currentResponder = elements.filter({ $0.currentResponder != nil }).first  else { return nil }
        return currentResponder
    }

    @objc func resignCurrentFirstResponder() {
        guard let elementContainingFirstResponder = currentResponderElement,
            let responder = elementContainingFirstResponder.currentResponder  else {
                return
        }
        responder.resignFirstResponder()
    }

    var respondersCount: Int {
        var count = 0
        for element in elements {
            guard let arrayOfResponders = element.respondersForInput else { continue }
            count += arrayOfResponders.count
        }
        return count
    }

    @objc func doneButtonPressed(_ sender: Any) {
        self.endEditing(true)
    }
    // MARK: Public interface
    public func scrollElementToVisible(_ element: DKFormElement, _ animated: Bool) {
        /// scroll an element to visible within the scroll view.
        guard let elementRect = self.containerView?.convert(element.frame, to: self) else { return }
        let totalRect = CGRect(x: elementRect.origin.x, y: elementRect.origin.y,
                               width: elementRect.size.width, height: elementRect.size.height)
        self.scrollRectToVisible(totalRect, animated: animated)
    }

    /*
     Because both elementBecomeFirstResponderWithDirection and scrollElementToVisible initiate scrolling
     simultaneously and cause a conflict, we will convert a UITextField frame into its DKFormElement frame.
     This will ensure the entire element comes into view.
     */
    func scrollRectToVisible(_ rect: CGRect, _ animated: Bool) {
        let overlaps = rect.elementsIntersectingRect(elements, view: self)
        var fullRect = rect
        for element in overlaps {
            fullRect = fullRect.union(element.convert(element.bounds, to: self))
        }
        super.scrollRectToVisible(fullRect, animated: animated)
    }

    private var fields: [DKFormField] {
        return elements.compactMap { $0 as? DKFormField }
    }

    open override var contentInset: UIEdgeInsets {
        get {
            return super.contentInset
        }
        set {
            let previousInset = self.contentInset
            super.contentInset = newValue
            guard let currentResponderElement = self.currentResponderElement,
                previousInset == newValue else { return }
            self.scrollElementToVisible(currentResponderElement, false)
        }
    }

    /// Assembles a DKFormData instance from the receiver's fields.
    private var collectDataFromFields: DKFormData? {
        guard fields.count > 0 else { return nil }
        var formData = DKFormData()
        for field in fields {
            guard field.identifier.isEmpty == false  else {
                fatalError(String.init(format: "Field %@ must have an identifier!", field))
            }
            formData.setValue(field.elementValue, field.identifier)
        }
        return formData
    }

    func set(data: DKFormData) {
        for formField in fields {
            formField.elementValue = data.valueForElementWithIdentifier(identifier: formField.identifier)
        }
    }

    public var formValidationResult: DKFormValidationResult {
        let result = DKFormValidationResult()
        result.data = collectDataFromFields
        for formField in fields {
            let fieldValue = result.data?.valueForElementWithIdentifier(identifier: formField.identifier)
            _ = formField.validate(fieldValue as Any)
        }
        return result
    }
}

// MARK: Constraint updating
extension DKForm {

    open override func updateConstraints() {
        NSLayoutConstraint.deactivate(previousConstraints)
        var viewConstraints = [NSLayoutConstraint]()
        viewConstraints += containerConstraints
        if headerView != nil {
            viewConstraints += constraints(nil, headerView)
        }
        var aboveView = headerView
        for element in elements {
            viewConstraints += constraints(aboveView, element)
            aboveView = element
        }
        viewConstraints += constraints(aboveView, footerView)
        viewConstraints += constraints(footerView, nil)
        previousConstraints = viewConstraints
        NSLayoutConstraint.activate(viewConstraints)
        super.updateConstraints()
    }

    private func constraints(_ topView: UIView?, _ bottomView: UIView?) -> [NSLayoutConstraint] {
        var viewConstraints = [NSLayoutConstraint]()
        guard topView != nil || bottomView != nil   else { return viewConstraints }
        var horizontalView: UIView?
        if topView == nil {
            // we should constrain to self's top.
            viewConstraints.append(NSLayoutConstraint(item: bottomView as Any, attribute: .top,
                                                      relatedBy: .equal, toItem: containerView,
                                                      attribute: .top, multiplier: 1.0, constant: 24))
            horizontalView = bottomView
        } else if bottomView != nil {
            // there is a topView and bottomView.
            viewConstraints.append(NSLayoutConstraint(item: bottomView as Any, attribute: .top,
                                                      relatedBy: .equal, toItem: topView,
                                                      attribute: .bottom, multiplier: 1.0, constant: 24))
            horizontalView = bottomView
        } else {
            // there is a topView and no bottomView
            viewConstraints.append(NSLayoutConstraint(item: topView as Any, attribute: .bottom,
                                                      relatedBy: .equal, toItem: containerView,
                                                      attribute: .bottom, multiplier: 1.0, constant: 0.0))
            horizontalView = nil
        }
        if horizontalView != nil {
            // horizontal
            viewConstraints.append(NSLayoutConstraint(item: horizontalView as Any, attribute: .centerX,
                                                      relatedBy: .equal, toItem: containerView,
                                                      attribute: .centerX, multiplier: 1.0, constant: 0.0))
            viewConstraints.append(NSLayoutConstraint(item: horizontalView as Any, attribute: .width,
                                                      relatedBy: .equal, toItem: containerView,
                                                      attribute: .width, multiplier: 1.0, constant: 0.0))
        }

        return viewConstraints
    }

    private var containerConstraints: [NSLayoutConstraint] {
        var viewConstraints = [NSLayoutConstraint]()
        viewConstraints.append(NSLayoutConstraint(item: outerContainerView as Any, attribute: .width,
                                                  relatedBy: .equal, toItem: self,
                                                  attribute: .width, multiplier: 1.0,
                                                  constant: 0.0))
        equalHeightConstraint = NSLayoutConstraint(item: self as Any, attribute: .height,
                                                   relatedBy: .equal, toItem: outerContainerView,
                                                   attribute: .height, multiplier: 1.0,
                                                   constant: 0.0)
        equalHeightConstraint?.priority = UILayoutPriority(rawValue: UILayoutPriority.defaultLow.rawValue - 2)
        viewConstraints.append(NSLayoutConstraint(item: outerContainerView as Any, attribute: .height,
                                                  relatedBy: .greaterThanOrEqual, toItem: self,
                                                  attribute: .height, multiplier: 1.0,
                                                  constant: 0.0))
        if let equalHeightConstraint = equalHeightConstraint { viewConstraints.append(equalHeightConstraint) }
        viewConstraints.append(NSLayoutConstraint(item: outerContainerView as Any, attribute: .top,
                                                  relatedBy: .equal, toItem: self,
                                                  attribute: .top, multiplier: 1.0,
                                                  constant: 0.0))
        viewConstraints.append(NSLayoutConstraint(item: outerContainerView as Any, attribute: .bottom,
                                                  relatedBy: .equal, toItem: self,
                                                  attribute: .bottom, multiplier: 1.0,
                                                  constant: 0.0))
        viewConstraints.append(NSLayoutConstraint(item: outerContainerView as Any, attribute: .leading,
                                                  relatedBy: .equal, toItem: self,
                                                  attribute: .leading, multiplier: 1.0,
                                                  constant: 0.0))
        viewConstraints.append(NSLayoutConstraint(item: outerContainerView as Any, attribute: .trailing,
                                                  relatedBy: .equal, toItem: self,
                                                  attribute: .trailing, multiplier: 1.0,
                                                  constant: 0.0))

        viewConstraints.append(NSLayoutConstraint(item: containerView as Any, attribute: .leading,
                                                  relatedBy: .equal, toItem: outerContainerView,
                                                  attribute: .leading, multiplier: 1.0,
                                                  constant: 24))
        viewConstraints.append(NSLayoutConstraint(item: containerView as Any, attribute: .trailing,
                                                  relatedBy: .equal, toItem: outerContainerView,
                                                  attribute: .trailing, multiplier: 1.0,
                                                  constant: -24))
        if screenMode == .centered {
            let centerYConstant = (self.layoutMargins.top - self.layoutMargins.bottom) / 2.0
            let containerVerticalConstraint = NSLayoutConstraint(item: containerView as Any, attribute: .centerY,
                                                                 relatedBy: .equal, toItem: outerContainerView,
                                                                 attribute: .centerY, multiplier: 1.0,
                                                                 constant: centerYConstant)
            containerVerticalConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.defaultLow.rawValue - 1)
            viewConstraints.append(containerVerticalConstraint)
            viewConstraints.append(NSLayoutConstraint(item: containerView as Any, attribute: .top,
                                                      relatedBy: .greaterThanOrEqual, toItem: outerContainerView,
                                                      attribute: .top, multiplier: 1.0,
                                                      constant: 0.0))
        } else {
            viewConstraints.append(NSLayoutConstraint(item: containerView as Any, attribute: .top,
                                                      relatedBy: .equal, toItem: outerContainerView,
                                                      attribute: .top, multiplier: 1.0,
                                                      constant: 0.0))
        }
        viewConstraints.append(NSLayoutConstraint(item: outerContainerView as Any, attribute: .bottom,
                                                  relatedBy: .greaterThanOrEqual, toItem: containerView,
                                                  attribute: .bottom, multiplier: 1.0,
                                                  constant: 0.0))
        // create the top constraint.
        return viewConstraints
    }
}
