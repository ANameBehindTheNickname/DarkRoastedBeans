//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

struct ExpandedItemConfiguration: UIContentConfiguration {
    let viewModel: ItemViewModel
    let expandedContentViewModels: [ItemViewModel]
    
    init(viewModel: ItemViewModel, expandedContentViewModels: [ItemViewModel]) {
        self.viewModel = viewModel
        self.expandedContentViewModels = expandedContentViewModels
    }
    
    func makeContentView() -> UIView & UIContentView {
        ExpandedItemContentView(self)
    }
    
    func updated(for state: UIConfigurationState) -> ExpandedItemConfiguration {
        self
    }
}
