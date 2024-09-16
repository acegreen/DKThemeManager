//
//  DKFormViewController.swift
//  DittoKit
//
//  Copied from https://github.com/AudaxHealthInc/forms
//  Created by Avinash Dongarwar on 11/20/17.
//

import UIKit

/**
 `DKFormNextViewController` instance managing -

 * Keyboard notifications, Keyboard accessory views and input types.
 * Appearance/Disappearnce of `DKFormNextButton` instance depending on validation results.
 * Laying out and applying relevant constraints to `DKForm` instance.
 */
open class DKFormViewController: UIViewController, DKFormDelegate {

    public var formView = DKForm(frame: .zero)
    private var lowered =  false
    private var keyboardObserver: NSObjectProtocol?

    open override func viewDidLoad() {
        super.viewDidLoad()
        if formView.superview == nil {
            view.addSubview(formView)
        }
        edgesForExtendedLayout = []
        formView.formDelegate = self
        formView.translatesAutoresizingMaskIntoConstraints = false
        formView.alwaysBounceVertical = true
        // add a tap gesture recognizer to dismiss the keyboard.
        formView.addGestureRecognizer(UITapGestureRecognizer(target: formView,
                                                             action: #selector(DKForm.resignCurrentFirstResponder)))
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard keyboardObserver == nil else { return }
        keyboardObserver = NotificationCenter.default.addObserver(forName:
                UIResponder.keyboardWillChangeFrameNotification, object: nil,
                                                             queue: OperationQueue.main, using: { [weak self] (note) in
                                                                guard let strongSelf = self else { return }
                                                                strongSelf.handle(notification: note)
        })
    }

    private func handle(notification: Notification) {
        // handle the keyboard notification.
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
            let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            // pull out the animation duration.
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let window = self.view.window else { return }

        // some frame handling code taken from:
        // http://www.cocoanetics.com/2011/07/calculating-area-covered-by-keyboard/
        let ownFrame = window.convert(self.view.frame, from: self.view.superview)
        // calculate the area of own frame that is covered by keyboard
        var coveredFrame = ownFrame.intersection(keyboardFrame)
        // now this might be rotated, so convert it back
        coveredFrame = window.convert(coveredFrame, to: self.view.superview)
        let keyboardHeight = UIScreen.main.bounds.maxY == keyboardFrame.minY ? 0.0 : coveredFrame.height
        self.formView.bottomContentSizeInset = keyboardHeight
        UIView.performWithoutAnimation {
            for  element in self.formView.elements {
                element.layoutIfNeeded()
            }
        }
        // allow subclasses to customize behavior
        // convert the curve to an animation option curve. Also add the begin from current state option.
        self.performChanges(forNewKeyboardHeight: keyboardHeight)
        UIView.animate(withDuration: duration, delay: 0.0,
                       options: UIView.AnimationOptions(rawValue:
                        UInt(curve << 16)),
                       animations: {
                        self.view.layoutIfNeeded()
        }, completion: nil)
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(keyboardObserver as Any)
        keyboardObserver = nil
    }

    func performChanges(forNewKeyboardHeight keyboardHeight: CGFloat) {
        // override point for subclasses - do nothing by default
    }

    open func form(_ form: DKForm, didChange result: DKFormValidationResult) {
    }
}
