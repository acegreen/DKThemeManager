//
//  DKThemeStyledNavigationBar.swift
//  DittoKit
//
//  Created by Ace Green on 1/11/21.
//
import UIKit

//Note: Use UIBarButtonItem with style done for any primary actions and its text color will be automatically set based on current theme
@IBDesignable
open class DKThemeStyledNavigationBar: UINavigationBar {

    enum ButtonAppearanceType {
        case back, plain, done
    }

    @available(iOS 13.0, *)
    var themeStyledAppearance: UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = themedStyle.type.backgroundColor
        appearance.titleTextAttributes = themedStyle.type.getTitleTextAttributes()
        appearance.largeTitleTextAttributes = themedStyle.type.getLargeTitleTextAttributes()
        appearance.backButtonAppearance = buttonAppearance(for: .back)
        appearance.setBackIndicatorImage(DKRDSIcons.chevronLeft.image, transitionMaskImage: DKRDSIcons.chevronLeft.image)
        appearance.buttonAppearance = buttonAppearance(for: .plain)
        appearance.doneButtonAppearance = buttonAppearance(for: .done)
        return appearance
    }

    // Programmatically: use the enum
    public var themedStyle: DKThemeNavigationBarStyle = .defaultNavigationBar {
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
            self.themedStyle = DKThemeNavigationBarStyle(rawValue: index) ?? .defaultNavigationBar
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        update()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        update()
    }

    private func update() {
        setStyle(navigationBarStyle: themedStyle.type)
    }

    private func setStyle(navigationBarStyle: DKNavigationBar) {
        tintColor = themedStyle.type.tintColor
        backgroundColor = themedStyle.type.backgroundColor
        isTranslucent = false

        if #available(iOS 13.0, *) {
            standardAppearance = themeStyledAppearance
            compactAppearance = themeStyledAppearance
            scrollEdgeAppearance = themeStyledAppearance
        } else {
            titleTextAttributes = themedStyle.type.getTitleTextAttributes()
            largeTitleTextAttributes = themedStyle.type.getLargeTitleTextAttributes()
            tintColor = navigationBarStyle.tintColor
            backgroundColor = navigationBarStyle.backgroundColor
            barTintColor = navigationBarStyle.backgroundColor
            backIndicatorImage = DKRDSIcons.chevronLeft.image
            backIndicatorTransitionMaskImage = DKRDSIcons.chevronLeft.image
        }
    }

    @available(iOS 13.0, *)
    private func buttonAppearance(for type: ButtonAppearanceType) -> UIBarButtonItemAppearance {
        let buttonAppearance = UIBarButtonItemAppearance()
        let normalState = buttonAppearance.normal
        let selectedState = buttonAppearance.highlighted
        switch type {
        case .back:
            normalState.titleTextAttributes = themedStyle.type.getBackButtonTitleTextAttributes(for: .normal)
            selectedState.titleTextAttributes = themedStyle.type.getBackButtonTitleTextAttributes(for: .selected)
        case .done:
            normalState.titleTextAttributes = themedStyle.type.getDoneButtonTitleTextAttributes(for: .normal)
            selectedState.titleTextAttributes = themedStyle.type.getDoneButtonTitleTextAttributes(for: .selected)
        case .plain:
            normalState.titleTextAttributes = themedStyle.type.getDefaultButtonTitleTextAttributes(for: .normal)
            selectedState.titleTextAttributes = themedStyle.type.getDefaultButtonTitleTextAttributes(for: .selected)
        }
        return buttonAppearance
    }
}
