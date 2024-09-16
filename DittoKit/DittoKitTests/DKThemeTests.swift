//
//  DKThemeTests.swift
//  DittoKitTests
//
//  Created by Ace Green on 4/7/21.
//

import XCTest
@testable import DittoKit

class DKThemeTests: XCTestCase {

    func testDefaultTheme() throws {
        let defaultTheme = DKThemeManager.shared.current
        let h1Font = DKDefaultThemeFonts.shared.h1
        let brandColor = DKDefaultThemeColors.shared.brand
        XCTAssert(defaultTheme.fonts.h1 == h1Font)
        XCTAssert(defaultTheme.colors.brand == brandColor)
        // TDA: all the assertion need to be add here
    }
}
