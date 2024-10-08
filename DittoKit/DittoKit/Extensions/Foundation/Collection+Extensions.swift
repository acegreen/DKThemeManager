//
//  Collection+Extensions.swift
//  DittoKit
//
//  Created by Ace Green on 4/6/21.
//

import Foundation

public extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
