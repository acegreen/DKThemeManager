//
//  DKThemeStyledTogglesViewController.swift
//  DittoApp
//
//  Created by Carl Burnham on 5/4/21.
//

import UIKit
import DittoKit

class DKToggleButtonExampleData {
    let text: String
    var selected: Bool

    init(text: String, selected: Bool) {
        self.text = text
        self.selected = selected
    }
}

/// Example of a list of DKToggleButtons used inside a simple tableview
class DKThemeStyledTogglesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var toggleButtonGroup: DKThemeStyledToggleButtonStack!
    @IBOutlet weak var themedSwitch: DKThemeStyledSwitch!

    lazy var initalDataSource: [DKToggleButtonExampleData] = {
        var data: [DKToggleButtonExampleData] = []
        for i in 0..<20 {
            data.append(DKToggleButtonExampleData(text: "Checkbox \(i + 1)", selected: false))
        }
        return data
    }()

    var dataSource: [DKToggleButtonExampleData]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = initalDataSource

        // Can make choices from code or from storyboard
        let toggleButton1 = DKThemeStyledToggleButton(title: "Radio Button (code)", delegate: toggleButtonGroup)
        let toggleButton2 = DKThemeStyledToggleButton(title: "Radio Button (code)", delegate: toggleButtonGroup)
        toggleButtonGroup.append(toggles: [toggleButton1, toggleButton2])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        forceUpdateStyles()
    }

    private func forceUpdateStyles() {
        let navigationBar = navigationController as? DKThemeStyledNavigationController
        navigationBar?.themedStyle = client == .uhc ? .reverseNavigationBar : .blackTintedNavigationBar
        toggleButtonGroup.toggles.forEach { $0.themedStyle = $0.themedStyle }
        themedSwitch.themedStyle = .defaultSwitch
    }
}

extension DKThemeStyledTogglesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DKToggleButtonCellView.identifier, for: indexPath)
            as? DKToggleButtonCellView else {
                fatalError("dequeuing a cell with the specified identifier is failed")
        }

        if let cellData = dataSource?[indexPath.row] {
            cell.configure(cellData: cellData)
        }

        return cell
    }
}

class DKToggleButtonCellView: UITableViewCell {
    static let identifier = "DKToggleButtonCellView"
    var cellData: DKToggleButtonExampleData!

    @IBOutlet weak var toggleButton: DKThemeStyledToggleButton!

    func configure(cellData: DKToggleButtonExampleData) {
        self.cellData = cellData
        toggleButton.setTitle(cellData.text, for: .normal)
        toggleButton.isSelectedMarked = cellData.selected
        toggleButton.delegate = self
    }
}

extension DKToggleButtonCellView: DKToggleButtonDelegate {
    func toggleButtonTapped(button: DKThemeStyledToggleButton) {
        toggleButton.isSelectedMarked = !toggleButton.isSelectedMarked
        cellData.selected = toggleButton.isSelectedMarked
    }
}
