//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class TableConfiguration: NSObject, UIContentConfiguration {
    let viewModels: [ItemViewModel]
    
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

extension TableConfiguration: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expandedCell", for: indexPath) as? NewItemListCell
        let uncheckedVMs = viewModels.map {
            ItemViewModel(title: $0.title, logoName: "unchecked_circle")
        }
        
        cell?.contentConfiguration = CheckingItemConfiguration(viewModel: uncheckedVMs[indexPath.row])
        return cell ?? .init(style: .default, reuseIdentifier: nil)
    }
}
