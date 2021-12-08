//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class ItemListCell: UITableViewCell {
    // MARK: - Outlets
    
    @IBOutlet private var itemImageView: UIImageView!
    @IBOutlet private var itemNameLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Public methods
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func set(_ viewModel: ItemViewModel) {
        itemImageView.image = .init(named: viewModel.logoName)
        itemNameLabel.text = viewModel.title
    }
}
