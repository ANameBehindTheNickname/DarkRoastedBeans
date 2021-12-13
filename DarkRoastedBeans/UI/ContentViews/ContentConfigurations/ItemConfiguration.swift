//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

struct ItemConfiguration: UIContentConfiguration {
    let viewModel: ItemViewModel
    let isLineViewHidden: Bool
    
    var backgroundColor: UIColor {
        isLineViewHidden ? .init(red: 174 / 255, green: 215 / 255, blue: 160 / 255, alpha: 1) : .clear
    }

    var isShadowEnabled: Bool {
        isLineViewHidden
    }
    
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
