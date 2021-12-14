//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class BrewButtonVC: UIViewController {
    // MARK: - Subviews
    
    private let brewButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBackground
        button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 18)
        return button
    }()
    
    // MARK: - Public properites
    
    var onBrew: (() -> Void)?
    
    // MARK: - Init
    
    init(buttonTitle: String) {
        self.brewButton.setTitle(buttonTitle, for: .normal)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
//    override func loadView() {
//        view = brewButton
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(brewButton)
        constraintSubviews()
        brewButton.addTarget(self, action: #selector(brew), for: .touchUpInside)
        applyStyle()
    }
    
    // MARK: - Private methods
    
    private func constraintSubviews() {
        brewButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            brewButton.heightAnchor.constraint(equalToConstant: 94),
            brewButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            brewButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            brewButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 56),
            brewButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -56),
        ])
    }
    
    @objc private func brew() {
        onBrew?()
    }
    
    private func applyStyle() {
        brewButton.backgroundColor = .init(red: 174 / 255, green: 215 / 255, blue: 160 / 255, alpha: 1)
        
        // Round corners
        brewButton.layer.cornerRadius = 4
        
        // Shadow
        brewButton.layer.masksToBounds = false
        brewButton.layer.shadowColor = UIColor.black.cgColor
        brewButton.layer.shadowOpacity = 0.15
        brewButton.layer.shadowOffset = .init(width: 0, height: 1)
        brewButton.layer.shadowRadius = 2
        brewButton.layer.shouldRasterize = true
        brewButton.layer.rasterizationScale = UIScreen.main.scale
    }
}
