//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class TableConfiguration: NSObject, UIContentConfiguration {
    private(set) var tableItemConfigs: [UIContentConfiguration]
    private(set) var selectedSubitemRow: Int?
    
    init(tableItemConfigs: [UIContentConfiguration]) {
        self.tableItemConfigs = tableItemConfigs
    }
    
    func makeContentView() -> UIView & UIContentView {
        TableContentView(self)
    }
    
    func updated(for state: UIConfigurationState) -> TableConfiguration {
        self
    }
}

extension TableConfiguration: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if tableView.indexPathForSelectedRow == indexPath {
            tableView.deselectRow(at: indexPath, animated: false)
            selectedSubitemRow = nil
            let cell = tableView.cellForRow(at: indexPath)
            cell?.contentConfiguration = updateContentConfig(at: indexPath, with: "unchecked_circle")
            return nil
        }

        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSubitemRow = indexPath.row
        let cell = tableView.cellForRow(at: indexPath)
        cell?.contentConfiguration = updateContentConfig(at: indexPath, with: "checked_circle")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedSubitemRow = nil
        let cell = tableView.cellForRow(at: indexPath)
        cell?.contentConfiguration = updateContentConfig(at: indexPath, with: "unchecked_circle")
    }
    
    private func updateContentConfig(at indexPath: IndexPath, with name: String) -> UIContentConfiguration {
        guard let checkingItemConfig = tableItemConfigs[indexPath.row] as? CheckingItemConfiguration
        else { fatalError("Developer mistake. When TableConfiguration conforms to UITableViewDelegate, tableItemConfigs should be of type [CheckingItemConfiguration]") }
        
        let configVM = checkingItemConfig.viewModel
        tableItemConfigs[indexPath.row] = CheckingItemConfiguration(viewModel: .init(title: configVM.title, logoName: name))
        return tableItemConfigs[indexPath.row]
    }
}

extension TableConfiguration: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableItemConfigs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expandedCell", for: indexPath)
        cell.contentConfiguration = tableItemConfigs[indexPath.row]
        return cell
    }
}
