//
//  DKThemeStyledTabBar.swift
//  DittoKit
//
//  Created by Ace Green on 1/11/21.
//
import UIKit

@IBDesignable
open class DKThemeStyledTabBar: UITabBar {

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

    public override init(frame: CGRect) {
        super.init(frame: frame)
        update()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        update()
    }

    // Programmatically: use the enum
    public var themedStyle: DKThemeTabBarStyle = .defaultTabBar {
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
            self.themedStyle = DKThemeTabBarStyle(rawValue: index) ?? .defaultTabBar
        }
    }

    private func update() {
        setStyle(tabBarStyle: themedStyle.type)
    }

    private func setStyle(tabBarStyle: DKTabBar) {
        isTranslucent = false

        if #available(iOS 13.0, *) {
            standardAppearance = themeStyledAppearance
        } else {
            backgroundColor = tabBarStyle.backgroundColor
            tintColor = tabBarStyle.titleColor
            UITabBarItem.appearance().setTitleTextAttributes(themedStyle.type.getTitleTextAttributes(), for: .normal)
            UITabBarItem.appearance().setTitleTextAttributes(themedStyle.type.getSelectedTitleTextAttributes(), for: .selected)
        }
    }
}
