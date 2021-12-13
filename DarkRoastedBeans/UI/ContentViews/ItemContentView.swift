//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class ItemContentView: UIView, UIContentView {
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var backingView: UIView!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var label: UILabel!
    
    var configuration: UIContentConfiguration {
        didSet {
            configure(with: configuration)
        }
    }
    
    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame:.zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBackgroundColor(_ color: UIColor) {
        backingView.backgroundColor = color
    }
    
    func turnOffShadow() {
        backingView.layer.shadowOpacity = 0
    }
    
    private func commonInit() {
        let nibName = String(describing: ItemContentView.self)
        Bundle.main.loadNibNamed(nibName, owner: self)
        addSubview(contentView)
        configure(with: configuration)
        constraintSubviews()
        styleSubviews()
    }
    
    private func configure(with configuration: UIContentConfiguration) {
        guard let config = configuration as? ItemConfiguration else { return }
        
        imageView.image = .init(named: config.viewModel.logoName)
        label.text = config.viewModel.title
    }
    
    private func constraintSubviews() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func styleSubviews() {
        contentView.backgroundColor = .clear
        
        // Round corners
        backingView.backgroundColor = .init(red: 174 / 255, green: 215 / 255, blue: 160 / 255, alpha: 1)
        backingView.layer.cornerRadius = 4
        
        // Shadow
        backingView.applyAppDefaultShadow()
        
        label.font = .init(name: "AvenirNext-DemiBold", size: 14)
        label.textColor = .white
    }
}