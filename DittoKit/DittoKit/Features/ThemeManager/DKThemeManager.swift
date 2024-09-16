//
//  DKThemeManager.swift
//  DittoKit
//
//  Created by Ace Green on 4/7/21.
//

import UIKit

// MARK: - DKThemeManager

public class DKThemeManager {

    public static let shared = DKThemeManager()

    /// Current Theme
    public var current = DKTheme(fonts: DKDefaultThemeFonts(), colors: DKDefaultThemeColors())

    private init() {}

    convenience init(theme: DKTheme) {
        self.init()
        self.current = theme
    }
}
