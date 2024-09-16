//
//  DKThemeStyledTabBarController.swift
//  DittoKit
//
//  Created by Ace Green on 1/11/21.
//

import UIKit

open class DKThemeStyledTabBarController: UITabBarController {

    @available(iOS 13.0, *)
    var themeStyledAppearance: UITabBarAppearance {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = themedStyle.type.backgroundColor
        appearance.stackedLayoutAppearance.normal.iconColor = themedStyle.type.titleColor
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = themedStyle.type.getTitleTextAttributes()
        appearance.stackedLayoutAppearance.selected.iconColor = themedStyle.type.selectedTitleColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = themedStyle.type.getSelectedTitleTextAttributes()
        return appearance
    }

    public init() {
        super.init(nibName: nil, bundle: nil)
        setStyle()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setStyle()
    }

    public var themedStyle: DKThemeTabBarStyle = .defaultTabBar {
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
            self.themedStyle = DKThemeTabBarStyle(rawValue: index) ?? .defaultTabBar
        }
    }

    private func setStyle() {
        let tabBarStyle = themedStyle.type
        tabBar.isTranslucent = false

        if #available(iOS 13.0, *) {
            tabBar.standardAppearance = themeStyledAppearance
        } else {
            tabBar.backgroundColor = tabBarStyle.backgroundColor
            tabBar.tintColor = tabBarStyle.titleColor
            tabBar.unselectedItemTintColor = tabBarStyle.titleColor
            UITabBarItem.appearance().setTitleTextAttributes(tabBarStyle.getTitleTextAttributes(), for: .normal)
            UITabBarItem.appearance().setTitleTextAttributes(tabBarStyle.getSelectedTitleTextAttributes(), for: .selected)
        }
    }
}
