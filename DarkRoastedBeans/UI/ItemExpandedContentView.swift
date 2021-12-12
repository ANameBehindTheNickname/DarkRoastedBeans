//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class ItemExpandedContentView: UIView, UIContentView {
    var configuration: UIContentConfiguration
    
    private let itemContentView: ItemContentView
    private let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.text = "Test view"
        label.font = UIFont(name: "AvenirNext-Bold", size: 32)
        return label
    }()
    
    init(_ configuration: UIContentConfiguration) {
        guard let config = configuration as? ItemExpandedContentConfiguration else {
            fatalError("Developer mistake. Should be of type ItemExpandedContentConfiguration")
        }
        
        self.configuration = config
        let itemContentViewConfiguration = ItemContentConfiguration(viewModel: config.viewModel)
        itemContentView = .init(itemContentViewConfiguration)
        super.init(frame:.zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        addSubview(itemContentView)
        addSubview(label)
        constraintSubviews()
    }
    
    private func constraintSubviews() {
        itemContentView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemContentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemContentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemContentView.topAnchor.constraint(equalTo: topAnchor),
            itemContentView.bottomAnchor.constraint(equalTo: label.topAnchor),
            
            label.heightAnchor.constraint(equalToConstant: 70),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
