//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class MachineVC: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet private weak var companyNameLabel: UILabel!
    @IBOutlet private weak var startInstructionLabel: UILabel!
    
    // MARK: - Public properites
    
    var onViewDidLoad: (() -> Void)?
    
    // MARK: - Private properites
    
    private let viewModel: MachineVCViewModel
    
    // MARK: - Init
    
    init(viewModel: MachineVCViewModel) {
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
