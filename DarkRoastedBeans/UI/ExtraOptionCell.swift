//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class ExtraOptionCell: UITableViewCell {
    // MARK: - Outlets
    
    @IBOutlet private var backingView: UIView!
    @IBOutlet private(set) var optionLabel: UILabel!
    @IBOutlet private var checkmarkImageView: UIImageView!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        styleSubviews()
    }
    
    // MARK: - Public methods
    
    func check() {
        checkmarkImageView.image = .init(named: "checked_circle")
    }
    
    func uncheck() {
        checkmarkImageView.image = .init(named: "unchecked_circle")
    }
    
    // MARK: - Private methods
    
    private func styleSubviews() {
        backgroundColor = .clear
        
        backingView.backgroundColor = .init(red: 155 / 255, green: 200 / 255, blue: 139 / 255, alpha: 1)
        backingView.layer.cornerRadius = 8
        
        optionLabel.font = .init(name: "AvenirNext-DemiBold", size: 14)
        optionLabel.textColor = .white
        checkmarkImageView.image = .init(named: "unchecked_circle")
    }
}
