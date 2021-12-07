//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class MachineConnectingVC: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet private weak var companyNameLabel: UILabel!
    @IBOutlet private weak var startInstructionLabel: UILabel!
    
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
        
        companyNameLabel.text = viewModel.companyName
        startInstructionLabel.text = viewModel.startInstruction
        
        // Simulate machine connection
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.onViewDidLoad?()
        }
    }
}
