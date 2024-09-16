//
//  DKThemeStyledViewController.swift
//  DittoKit
//
//  Created by Ace Green on 3/2/21.
//
import UIKit

/// Style guide Requirements https://app.zeplin.io/project/5d782673039b774ecd758243/screen/5d79e44468f73118f9a12d3d
open class DKThemeStyledTableViewController: UITableViewController {

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        if navigationItemBackButtonTextIsHidden {
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }
}

open class DKThemeStyledViewController: UIViewController {

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        if navigationItemBackButtonTextIsHidden {
            let backBarButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            backBarButton.accessibilityLabel = NSLocalizedString("Back", comment: "")
            navigationItem.backBarButtonItem = backBarButton
        }
    }
}
