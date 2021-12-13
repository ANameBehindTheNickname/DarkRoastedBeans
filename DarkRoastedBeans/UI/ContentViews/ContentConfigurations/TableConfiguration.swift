//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class TableConfiguration: NSObject, UIContentConfiguration {
    private(set) var tableItemConfigs: [CheckingItemConfiguration]
    private(set) var selectedSubitemRow: Int?
    
    init(tableItemConfigs: [CheckingItemConfiguration]) {
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
            let cell = tableView.cellForRow(at: indexPath) as? NewItemListCell
            let configVM = tableItemConfigs[indexPath.row].viewModel
            tableItemConfigs[indexPath.row] = .init(viewModel: .init(title: configVM.title, logoName: "unchecked_circle"))
            let config = tableItemConfigs[indexPath.row]
            cell?.contentConfiguration = config
            return nil
        }

        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSubitemRow = indexPath.row
        let cell = tableView.cellForRow(at: indexPath) as? NewItemListCell
        let configVM = tableItemConfigs[indexPath.row].viewModel
        tableItemConfigs[indexPath.row] = .init(viewModel: .init(title: configVM.title, logoName: "checked_circle"))
        let config = tableItemConfigs[indexPath.row]
        cell?.contentConfiguration = config
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedSubitemRow = nil
        let cell = tableView.cellForRow(at: indexPath) as? NewItemListCell
        let configVM = tableItemConfigs[indexPath.row].viewModel
        tableItemConfigs[indexPath.row] = .init(viewModel: .init(title: configVM.title, logoName: "unchecked_circle"))
        let config = tableItemConfigs[indexPath.row]
        cell?.contentConfiguration = config
    }
}

extension TableConfiguration: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableItemConfigs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expandedCell", for: indexPath) as? NewItemListCell
        cell?.contentConfiguration = tableItemConfigs[indexPath.row]
        return cell ?? .init(style: .default, reuseIdentifier: nil)
    }
}
