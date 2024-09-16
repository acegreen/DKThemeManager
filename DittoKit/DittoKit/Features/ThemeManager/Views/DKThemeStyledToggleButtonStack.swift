//
//  DKThemeStyledToggleButtonStack.swift
//  DittoKit
//
//  Created by Carl Burnham on 5/4/21.
//

import UIKit

public class DKThemeStyledToggleButtonStack: UIStackView {

    public var toggles: [DKThemeStyledToggleButton] = []

    @IBInspectable public var isMultiSelectionEnabled: Bool = false

    public func append(toggles: [DKThemeStyledToggleButton]) {
        self.toggles.append(contentsOf: toggles)
        toggles.forEach { addArrangedSubview($0) }
    }

    public required init(coder: NSCoder) {
        super.init(coder: coder)

        // If any views were made from storyboard then make their delegate the groups
        arrangedSubviews
            .compactMap { $0 as? DKThemeStyledToggleButton }
            .forEach { toggle in
                toggle.delegate = self
                toggles.append(toggle)
            }
    }
}

extension DKThemeStyledToggleButtonStack: DKToggleButtonDelegate {

    public func toggleButtonTapped(button: DKThemeStyledToggleButton) {
        if isMultiSelectionEnabled {
            button.isSelectedMarked = !button.isSelectedMarked
        } else {
            arrangedSubviews.forEach { button in
                (button as? DKThemeStyledToggleButton)?.isSelectedMarked = false
            }
            button.isSelectedMarked = true
        }
    }
}
