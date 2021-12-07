//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class BrewButtonVC: UIViewController {
    // MARK: - Subviews
    
    private let brewButton = UIButton()
    
    // MARK: - Public properites
    
    var onBrew: (() -> Void)?
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = brewButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        brewButton.backgroundColor = .green
        brewButton.addTarget(self, action: #selector(brew), for: .touchUpInside)
    }
    
    // MARK: - Private methods
    
    @objc private func brew() {
        onBrew?()
    }
}
