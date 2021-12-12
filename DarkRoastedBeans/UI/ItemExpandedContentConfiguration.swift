//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

struct ItemExpandedContentConfiguration: UIContentConfiguration {
    let viewModel: ItemViewModel
    
    init(viewModel: ItemViewModel) {
        self.viewModel = viewModel
    }
    
    func makeContentView() -> UIView & UIContentView {
        ItemExpandedContentView(self)
    }
    
    func updated(for state: UIConfigurationState) -> ItemExpandedContentConfiguration {
        self
    }
}
