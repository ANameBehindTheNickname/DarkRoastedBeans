//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

struct ItemConfiguration: UIContentConfiguration {
    let viewModel: ItemViewModel
    let isLineViewHidden: Bool
    
    init(viewModel: ItemViewModel, isLineViewHidden: Bool) {
        self.viewModel = viewModel
        self.isLineViewHidden = isLineViewHidden
    }
    
    func makeContentView() -> UIView & UIContentView {
        ItemContentView(self)
    }
    
    func updated(for state: UIConfigurationState) -> ItemConfiguration {
        self
    }
}
