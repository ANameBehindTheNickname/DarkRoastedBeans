//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

struct CheckingItemConfiguration: UIContentConfiguration {
    let viewModel: ItemViewModel
    
    init(viewModel: ItemViewModel) {
        self.viewModel = viewModel
    }
    
    func makeContentView() -> UIView & UIContentView {
        CheckingItemContentView(self)
    }
    
    func updated(for state: UIConfigurationState) -> CheckingItemConfiguration {
        self
    }
}

