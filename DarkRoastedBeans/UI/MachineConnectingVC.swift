//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class MachineConnectingVC: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet private weak var companyNameLabel: UILabel!
    @IBOutlet private weak var startInstructionLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var tutorialLabel: UILabel!
    
    
    // MARK: - Public properites
    
    var onViewDidLoad: (() -> Void)?
    
    // MARK: - Private properites
    
    private let viewModel: MachineConnectingVCViewModel
    
    // MARK: - Init
    
    init(viewModel: MachineConnectingVCViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSubviewsWithModels()
        styleSubviews()
        
        // Simulate machine connection
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.onViewDidLoad?()
        }
    }
    
    // MARK: - Private methods
    
    private func setSubviewsWithModels() {
        companyNameLabel.text = viewModel.companyName
        startInstructionLabel.text = viewModel.startInstruction
    }
    
    private func styleSubviews() {
        companyNameLabel.font = .init(name: "AvenirNext-Bold", size: 16)
        startInstructionLabel.font = .init(name: "AvenirNext-Medium", size: 24)
        imageView.contentMode = .scaleAspectFit
        imageView.image = .init(named: "machine_connect")
        
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: viewModel.tutorial, attributes: underlineAttribute)
        tutorialLabel.attributedText = underlineAttributedString
        tutorialLabel.font = .init(name: "AvenirNext-Medium", size: 16)
    }
}
