//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

struct ItemExpandedContentConfiguration: UIContentConfiguration {
    let viewModel: ItemViewModel
    let expandedContentViewModels: [ItemViewModel]
    
    init(viewModel: ItemViewModel, expandedContentViewModels: [ItemViewModel]) {
        self.viewModel = viewModel
        self.expandedContentViewModels = expandedContentViewModels
    }
    
    func makeContentView() -> UIView & UIContentView {
        ItemExpandedContentView(self)
    }
    
    func updated(for state: UIConfigurationState) -> ItemExpandedContentConfiguration {
        self
    }
}
