//
//  DKCustomTheme.swift
//  DittoKit
//
//  Created by Ace Green on 4/7/21.
//

import UIKit

public class DKCustomTheme: DKTheme {

    public let primaryColor: UIColor

    public init(primaryColor: UIColor) {
        self.primaryColor = primaryColor
        super.init(fonts: DKCustomThemeFonts(),
                   colors: DKCustomThemeColors())
    }
}

// MARK: - Custom Theme Fonts

public class DKCustomThemeFonts: DKDefaultThemeFonts { }

// MARK: - Custom Theme Colors

public class DKCustomThemeColors: DKDefaultThemeColors {

    public override var brand: UIColor {
        return DKConstants.primaryColor
    }

    public override var link: UIColor {
        return DKConstants.primaryColor
    }
}
