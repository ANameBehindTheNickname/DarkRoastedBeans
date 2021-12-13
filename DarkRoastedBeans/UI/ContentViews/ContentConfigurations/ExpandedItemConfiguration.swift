//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

struct ExpandedItemConfiguration: UIContentConfiguration {
    let itemConfiguration: ItemConfiguration
    let tableConfiguration: TableConfiguration
    
    init(itemConfiguration: ItemConfiguration, tableConfiguration: TableConfiguration) {
        self.itemConfiguration = itemConfiguration
        self.tableConfiguration = tableConfiguration
    }
    
    func makeContentView() -> UIView & UIContentView {
        ExpandedItemContentView(self)
    }
    
    func updated(for state: UIConfigurationState) -> ExpandedItemConfiguration {
        self
    }
}
