//
//  CGRect+Extensions.swift
//  DittoKit
//
//  Copied from https://github.com/AudaxHealthInc/forms
//  Created by Avinash Dongarwar on 11/20/17.
//

import UIKit

extension CGRect {
    func elementsIntersectingRect(_ elements: [DKFormElement], view: UIView) -> [DKFormElement] {
        // get every element intersecting the incoming rect.
        var overlappingElements = [DKFormElement]()
        for element in elements {
            let convertedRect = element.convert(element.bounds, to: view)
            guard self.intersects(convertedRect) else { continue }
            overlappingElements.append(element)
        }
        return overlappingElements
    }
}
