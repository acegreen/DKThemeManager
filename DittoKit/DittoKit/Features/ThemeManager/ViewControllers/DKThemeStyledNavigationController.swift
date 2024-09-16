//
//  DKThemeStyledNavigationController.swift
//  DittoKit
//
//  Created by Ace Green on 1/13/21.
//
import UIKit

open class DKThemeStyledNavigationController: UINavigationController {

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

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    open override var childForStatusBarStyle: UIViewController? {
        return nil
    }

    public var prefersLargeTitles: Bool = false {
        didSet {
            navigationBar.prefersLargeTitles = prefersLargeTitles
        }
    }

    public var themedStyle: DKThemeNavigationBarStyle = .defaultNavigationBar {
        didSet {
            setStyle()
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

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setStyle()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setStyle()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setStyle()
    }

    private func setStyle() {
        navigationBar.tintColor = themedStyle.type.tintColor
        navigationBar.backgroundColor = themedStyle.type.backgroundColor
        navigationBar.isTranslucent = false
        prefersLargeTitles = themedStyle.type.prefersLargeTitles

        if #available(iOS 13.0, *) {
            navigationBar.standardAppearance = themeStyledAppearance
            navigationBar.compactAppearance = themeStyledAppearance
            navigationBar.scrollEdgeAppearance = themeStyledAppearance
        } else {
            navigationBar.titleTextAttributes = themedStyle.type.getTitleTextAttributes()
            navigationBar.largeTitleTextAttributes = themedStyle.type.getLargeTitleTextAttributes()
            navigationBar.barTintColor = themedStyle.type.backgroundColor
            navigationBar.backIndicatorImage = DKRDSIcons.chevronLeft.image
            navigationBar.backIndicatorTransitionMaskImage = DKRDSIcons.chevronLeft.image
        }
    }

    @available(iOS 13.0, *)
    private func buttonAppearance(for type: DKThemeStyledNavigationBar.ButtonAppearanceType) -> UIBarButtonItemAppearance {
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
