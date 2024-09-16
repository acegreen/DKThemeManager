//
//  String+Extensions.swift
//  DittoKit
//
//  Created by Ace Green on 4/6/21.
//

import Foundation

public extension String {

    /// Returns a Boolean value indicating whether the string contains a character from the given character set.
    ///
    /// - Parameter characterSet: The set of characters to search for in the string
    /// - Returns: true if a character from the character set was found in the string; otherwise, false.
    func containsCharacters(from characterSet: CharacterSet) -> Bool {
        return self.rangeOfCharacter(from: characterSet) != nil
    }
}
