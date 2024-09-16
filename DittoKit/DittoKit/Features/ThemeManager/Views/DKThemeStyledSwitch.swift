//
//  DKThemeStyledSwitch.swift
//  DittoKit
//
//  Created by Kiran Kumar Gopi on 2/24/21.
//

import UIKit

@IBDesignable
open class DKThemeStyledSwitch: UISwitch {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.update()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.update()
    }

    // Programmatically: use the enum
    public var themedStyle: DKThemeSwitchStyle = .defaultSwitch {
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
            self.themedStyle = DKThemeSwitchStyle(rawValue: index) ?? .defaultSwitch
        }
    }

    private func update() {
        onTintColor = themedStyle.type.tintColor
    }

}
