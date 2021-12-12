//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

struct ItemContentConfiguration: UIContentConfiguration {
    let viewModel: ItemViewModel
    
    init(viewModel: ItemViewModel) {
        self.viewModel = viewModel
    }
    
    func makeContentView() -> UIView & UIContentView {
        ItemContentView(self)
    }
    
    func updated(for state: UIConfigurationState) -> ItemContentConfiguration {
        self
    }
}
