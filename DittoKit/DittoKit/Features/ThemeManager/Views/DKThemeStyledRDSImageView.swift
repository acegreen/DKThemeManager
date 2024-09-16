//
//  DKThemeStyledRDSImageView.swift
//  DittoKit
//
//  Created by Kiran Kumar Gopi on 3/18/21.
//

import UIKit

@IBDesignable
open class DKThemeStyledRDSImageView: UIImageView {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.update()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.update()
    }

    // Programmatically: use the enum
    public var rdsIcon: DKRDSIcons? {
        didSet {
            update()
        }
    }

    // IB: use the adapter
    @IBInspectable public var rdsAdapter: String {
        get {
            return self.rdsIcon?.rawValue ?? ""
        }
        set(rdsIconName) {
            self.rdsIcon = DKRDSIcons(rawValue: rdsIconName)
        }
    }

    private func update() {
        let style = DKThemeImageStyle.defaultImage
        tintColor = style.type.tintColor
        contentMode = .scaleAspectFit
        if let rdsImage = rdsIcon?.image {
            image = rdsImage
        }
    }
}
