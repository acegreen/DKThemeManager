//
//  DKThemeStyledSegmentedControl.swift
//  DittoKit
//
//  Created by Ace Green on 1/8/21.
//

import UIKit

public class DKSegmentSelectionView: UIView {}

@IBDesignable
open class DKThemeStyledSegmentedControl: UISegmentedControl {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        update()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        update()
    }

    // Programmatically: use the enum
    public var themedStyle: DKThemeSegmentControlStyle = .defaultSegmentedControl {
        didSet {
            update()
        }
    }

    // IB: use the adapter
    @IBInspectable public var themedStyleAdapter: String {
        get {
            return self.themedStyle.rawValue
        }
        set(index) {
            self.themedStyle = DKThemeSegmentControlStyle(rawValue: index) ?? .defaultSegmentedControl
        }
    }

    var alignment: UIControl.ContentHorizontalAlignment? {
        didSet {
            update()
        }
    }

    // this will be used to style the selection of the segmented control
    private var selectionView = DKSegmentSelectionView()
    private var selectionViewBottomAnchor: NSLayoutConstraint?
    private var selectionViewHeightAnchor: NSLayoutConstraint?
    private var selectionViewLeftAnchor: NSLayoutConstraint?
    private var selectionViewWidthAnchor: NSLayoutConstraint?

    private let underlineHeight: CGFloat = 2

    private var segmentViews: [UIView] {
        return subviews.filter { !($0.isMember(of: DKSegmentSelectionView.self)) && !($0.isMember(of: UIImageView.self)) }
            .sorted(by: { $0.frame.origin.x < $1.frame.origin.x })
    }

    private func update() {
        setStyle(segmentedStyle: themedStyle.type)
    }

    private func setStyle(segmentedStyle: DKSegmentedControl) {
        setHeight(segmentedStyle: segmentedStyle)
        setViewStyle(segmentedStyle: segmentedStyle)
        setSelectionStyle(segmentedStyle: segmentedStyle)
    }

    private func setViewStyle(segmentedStyle: DKSegmentedControl) {
        backgroundColor = .clear
        tintColor = .clear
        if #available(iOS 13.0, *) {
            setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
            setBackgroundImage(UIImage(), for: .selected, barMetrics: .default)
            setBackgroundImage(UIImage(), for: .highlighted, barMetrics: .default)
            setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)

            if case DKSegmentedControlSelectionStyle.background = segmentedStyle.selectionStyle {
                layer.borderWidth = 1
                layer.borderColor = themedStyle.type.borderColor.cgColor
                layer.masksToBounds = true
            } else if case DKSegmentedControlSelectionStyle.underlineBar = segmentedStyle.selectionStyle {
                layer.borderWidth = 0
                layer.cornerRadius = 0
                layer.masksToBounds = false
            }
        }

        setTitleTextAttributes(themedStyle.type.getStringAttributes(), for: .normal)
        setTitleTextAttributes(themedStyle.type.getSelectedStringAttributes(), for: .selected)

        apportionsSegmentWidthsByContent = !segmentedStyle.equalWidthSegments

        guard let textAlignment = alignment else { return }
        contentHorizontalAlignment = textAlignment
    }

    private func setSelectionStyle(segmentedStyle: DKSegmentedControl) {

        selectionView.removeFromSuperview()
        selectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(selectionView)

        guard let selectedSegment = getSegment(at: selectedSegmentIndex) else { return }

        switch segmentedStyle.selectionStyle {
        case .background:
            selectionView.backgroundColor = themedStyle.type.borderColor
            selectionViewBottomAnchor = selectionView.topAnchor.constraint(equalTo: topAnchor)
            selectionViewBottomAnchor?.isActive = true
            selectionViewHeightAnchor = selectionView.heightAnchor.constraint(equalTo: heightAnchor)
            selectionViewHeightAnchor?.isActive = true

        case .underlineBar(let color):
            selectionView.backgroundColor = color
            selectionViewBottomAnchor = selectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            selectionViewBottomAnchor?.isActive = true
            selectionViewHeightAnchor = selectionView.heightAnchor.constraint(equalToConstant: underlineHeight)
            selectionViewHeightAnchor?.isActive = true

            bringSubviewToFront(selectionView)
        }

        selectionViewLeftAnchor = selectionView.leftAnchor.constraint(equalTo: selectedSegment.leftAnchor)
        selectionViewLeftAnchor?.isActive = true
        selectionViewWidthAnchor = selectionView.widthAnchor.constraint(equalTo: selectedSegment.widthAnchor)
        selectionViewWidthAnchor?.isActive = true
        addTarget(self, action: #selector(self.valueChanged(_:)), for: .valueChanged)
    }

    private func setHeight(segmentedStyle: DKSegmentedControl) {
        heightAnchor.constraint(equalToConstant: segmentedStyle.height).isActive = true
    }

    @objc func valueChanged(_ sender: UISegmentedControl) {
        adjustSelectionViewPositon()
    }

    private func adjustSelectionViewPositon() {
        UIView.animate(withDuration: 0.3) {
            self.resetSelectionViewConstraints()
        }
    }

    private func resetSelectionViewConstraints() {

        guard let selectedSegment = getSegment(at: selectedSegmentIndex) else { return }
        switch themedStyle.type.selectionStyle {
        case .background:
            selectionViewBottomAnchor?.isActive = false
            selectionViewBottomAnchor = selectionView.topAnchor.constraint(equalTo: selectedSegment.topAnchor)
            selectionViewBottomAnchor?.isActive = true

            selectionViewHeightAnchor?.isActive = false
            selectionViewHeightAnchor = selectionView.heightAnchor.constraint(equalTo: selectedSegment.heightAnchor)
            selectionViewHeightAnchor?.isActive = true

        case .underlineBar:
            selectionViewBottomAnchor?.isActive = false
            selectionViewBottomAnchor = selectionView.bottomAnchor.constraint(equalTo: selectedSegment.bottomAnchor)
            selectionViewBottomAnchor?.isActive = true

            selectionViewHeightAnchor?.isActive = false
            selectionViewHeightAnchor = selectionView.heightAnchor.constraint(equalToConstant: underlineHeight)
            selectionViewHeightAnchor?.isActive = true
        }

        selectionViewLeftAnchor?.isActive = false
        selectionViewLeftAnchor = selectionView.leftAnchor.constraint(equalTo: selectedSegment.leftAnchor)
        selectionViewLeftAnchor?.isActive = true

        selectionViewWidthAnchor?.isActive = false
        selectionViewWidthAnchor = selectionView.widthAnchor.constraint(equalTo: selectedSegment.widthAnchor)
        selectionViewWidthAnchor?.isActive = true
    }

    public func getSegment(at index: Int) -> UIView? {
        return segmentViews[safe: index]
    }

    public override var selectedSegmentIndex: Int {
        didSet {
            adjustSelectionViewPositon()
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        resetSelectionViewConstraints()
    }
}
