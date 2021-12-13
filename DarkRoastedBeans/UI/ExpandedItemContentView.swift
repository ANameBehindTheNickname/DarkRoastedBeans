//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class ExpandedItemContentView: UIView, UIContentView {
    var configuration: UIContentConfiguration
    
    private let backingView = UIView()
    private let itemContentView: ItemContentView
    private let tableContentView: TableContentView
    
    private var viewSubviews: [UIView] {
        [backingView, itemContentView, tableContentView]
    }
    
    init(_ configuration: UIContentConfiguration) {
        guard let config = configuration as? ExpandedItemConfiguration else {
            fatalError("Developer mistake. Should be of type ExpandedItemConfiguration")
        }
        
        self.configuration = config
        let itemConfiguration = ItemConfiguration(viewModel: config.viewModel)
        let tableConfiguration = TableConfiguration(viewModels: config.expandedContentViewModels)
        itemContentView = .init(itemConfiguration)
        tableContentView = .init(tableConfiguration)
        super.init(frame:.zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        viewSubviews.forEach { addSubview($0) }
        
        constraintSubviews()
        configureUI()
    }
    
    private func constraintSubviews() {
        viewSubviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            backingView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backingView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            backingView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            backingView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            
            itemContentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemContentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemContentView.topAnchor.constraint(equalTo: topAnchor),
            itemContentView.bottomAnchor.constraint(equalTo: tableContentView.topAnchor, constant: 4),
            
            tableContentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            tableContentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            tableContentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)
        ])
    }
    
    private func configureUI() {
        backingView.backgroundColor = .init(red: 174 / 255, green: 215 / 255, blue: 160 / 255, alpha: 1)
        
        // Round corners
        backingView.backgroundColor = .init(red: 174 / 255, green: 215 / 255, blue: 160 / 255, alpha: 1)
        backingView.layer.cornerRadius = 4
        
        // Shadow
        backingView.layer.masksToBounds = false
        backingView.layer.shadowColor = UIColor.black.cgColor
        backingView.layer.shadowOpacity = 0.15
        backingView.layer.shadowOffset = .init(width: 0, height: 1)
        backingView.layer.shadowRadius = 2
        backingView.layer.shouldRasterize = true
        backingView.layer.rasterizationScale = UIScreen.main.scale
        
        itemContentView.turnOffShadow()
        itemContentView.setBackgroundColor(.clear)
    }
}
