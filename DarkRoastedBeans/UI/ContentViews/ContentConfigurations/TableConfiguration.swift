//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class TableConfiguration: NSObject, UIContentConfiguration {
    let viewModels: [ItemViewModel]
    private(set) var selectedSubitemRow: Int?
    
    init(viewModels: [ItemViewModel]) {
        self.viewModels = viewModels
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
            let currentVM = viewModels[indexPath.row]
            cell?.contentConfiguration = CheckingItemConfiguration(viewModel: .init(title: currentVM.title, logoName: "unchecked_circle"))
            return nil
        }

        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSubitemRow = indexPath.row
        let cell = tableView.cellForRow(at: indexPath) as? NewItemListCell
        let currentVM = viewModels[indexPath.row]
        cell?.contentConfiguration = CheckingItemConfiguration(viewModel: .init(title: currentVM.title, logoName: "checked_circle"))
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedSubitemRow = nil
        let cell = tableView.cellForRow(at: indexPath) as? NewItemListCell
        let currentVM = viewModels[indexPath.row]
        cell?.contentConfiguration = CheckingItemConfiguration(viewModel: .init(title: currentVM.title, logoName: "unchecked_circle"))
    }
}

extension TableConfiguration: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expandedCell", for: indexPath) as? NewItemListCell
        cell?.contentConfiguration = CheckingItemConfiguration(viewModel: viewModels[indexPath.row])
        return cell ?? .init(style: .default, reuseIdentifier: nil)
    }
}
