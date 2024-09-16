//
//  DKThemeStyledRDSButton.swift
//  DittoKit
//
//  Created by Kiran Kumar Gopi on 2/12/21.
//

import UIKit

@IBDesignable
open class DKThemeStyledRDSButton: UIButton {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.update()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.update()
    }

    // Programmatically: use the enum
    public var rds: DKRDSIcons? {
        didSet {
            update()
        }
    }

    // IB: use the adapter
    @IBInspectable public var rdsAdapter: String {
        get {
            return self.rds?.rawValue ?? ""
        }
        set(rdsIconName) {
            self.rds = DKRDSIcons(rawValue: rdsIconName)
        }
    }

    // Name of event to track when hitting button
    var eventName: String?

    // if the button exist in sections they should be listed here
    var eventSections: [String]?

    private func update() {
        let style = DKThemeImageStyle.defaultImage
        tintColor = style.type.tintColor
        setTitleColor(style.type.tintColor, for: .normal)
        if let rdsImage = rds?.image {
            setImage(rdsImage, for: .normal)
        }
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        // TRACK ANALYTICS
        if didTouchUpInside(touch: touches.first) {
            guard let name = eventName else { return }
            shouldTrack(event: name, inSections: eventSections)
        }
    }
}
