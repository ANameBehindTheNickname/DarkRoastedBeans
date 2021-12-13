//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class ItemExpandedContentView: UIView, UIContentView {
    var configuration: UIContentConfiguration
    
    private let itemContentView: ItemContentView
    private let tableContentView: TableContentView
    
    init(_ configuration: UIContentConfiguration) {
        guard let config = configuration as? ItemExpandedContentConfiguration else {
            fatalError("Developer mistake. Should be of type ItemExpandedContentConfiguration")
        }
        
        self.configuration = config
        let itemContentViewConfiguration = ItemContentConfiguration(viewModel: config.viewModel)
        let tableContentViewConfiguration = TableContentViewConfiguration(viewModels: config.expandedContentViewModels)
        itemContentView = .init(itemContentViewConfiguration)
        tableContentView = .init(tableContentViewConfiguration)
        super.init(frame:.zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        addSubview(itemContentView)
        addSubview(tableContentView)
        constraintSubviews()
    }
    
    private func constraintSubviews() {
        itemContentView.translatesAutoresizingMaskIntoConstraints = false
        tableContentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemContentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemContentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemContentView.topAnchor.constraint(equalTo: topAnchor),
            itemContentView.bottomAnchor.constraint(equalTo: tableContentView.topAnchor),
            
            tableContentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableContentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableContentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
