//
//  DKConstants.swift
//  DittoKit
//
//  Created by Ace Green on 4/6/21.
//

import UIKit

public struct DKConstants {

    static var primaryColor: UIColor {
        return (DKThemeManager.shared.current as? DKCustomTheme)?.primaryColor ?? DKDefaultThemeColors.shared.brand
    }

    static var isCustomTheme: Bool {
        return DKThemeManager.shared.current is DKCustomTheme
    }
}
