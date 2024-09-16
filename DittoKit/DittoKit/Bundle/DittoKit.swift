//
//  DittoKit.swift
//  DittoKit
//
//  Created by Ace Green on 4/6/21.
//

import UIKit

public class DittoKit: NSObject {
    static let bundleName = "DittoKit"

    // swiftlint:disable force_unwrapping
    public static let bundle = DKBundleHelper.bundle(named: DittoKit.bundleName)!
}
