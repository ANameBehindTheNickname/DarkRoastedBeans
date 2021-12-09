//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class ExtraOptionCell: UITableViewCell {
    // MARK: - Outlets
    
    @IBOutlet private var backingView: UIView!
    @IBOutlet private(set) var optionLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        styleSubviews()
    }
    
    // MARK: - Private methods
    
    private func styleSubviews() {
        backingView.backgroundColor = .orange
        backingView.layer.cornerRadius = 8
    }
}
