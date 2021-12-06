//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class DrinkBrewingFlow {
    // MARK: - Private properites
    
    private let navigation: UINavigationController
    private let brewingMachine: BrewingMachine
    
    private lazy var buttonController: NextButtonController = {
        let button = UIBarButtonItem(title: "Next", style: .plain, target: nil, action: nil)
        return .init(button)
    }()
    
    // MARK: - Init
    
    init(navigation: UINavigationController, brewingMachine: BrewingMachine) {
        self.navigation = navigation
        self.brewingMachine = brewingMachine
    }
    
    // MARK: - Public methods
    
    func start() {
        let title = "Select your style"
        let itemVMs = brewingMachine.drinks.map { ItemViewModel(title: $0, logoName: "") }
        let vc = ItemListVC(listTitle: title, itemViewModels: itemVMs)
        vc.onDidSelectRow = styleStepCompleted
        navigation.pushViewController(vc, animated: false)
    }
    
    // MARK: - Private methods
    
    private func styleStepCompleted(styleRow: Int) {
        let title = "Select your size"
        let itemVMs = brewingMachine.sizes.map { ItemViewModel(title: $0, logoName: "") }
        let vc = ItemListVC(listTitle: title, itemViewModels: itemVMs)
        vc.onDidSelectRow = { [weak self] in
            self?.sizeStepCompleted(styleRow: styleRow, sizeRow: $0)
        }
        
        navigation.pushViewController(vc, animated: true)
    }
    
    private func sizeStepCompleted(styleRow: Int, sizeRow: Int) {
        let title = "Select your extras"
        let itemVMs = brewingMachine.extras.map { ItemViewModel(title: $0.name, logoName: "") }
        let vc = ItemListVC(listTitle: title, itemViewModels: itemVMs)
        vc.onViewDidLoad = {
            vc.tableView.allowsMultipleSelection = true
        }
        
        buttonController.callback = { [weak self] in
            let selectedExtras = vc.tableView.indexPathsForSelectedRows?.map { $0.row } ?? []
            self?.extrasStepCompleted(styleRow: styleRow, sizeRow: sizeRow, extrasRows: selectedExtras)
        }
        
        vc.navigationItem.rightBarButtonItem = buttonController.button
        navigation.pushViewController(vc, animated: true)
    }
    
    private func extrasStepCompleted(styleRow: Int, sizeRow: Int, extrasRows: [Int]) {
        let title = "Overview"
        let drink = brewingMachine.drinks[styleRow]
        let size = brewingMachine.sizes[sizeRow]
        let extras = extrasRows.map { brewingMachine.extras[$0] }.map { $0.name }
        let itemVMs = ([drink, size] + extras).map { ItemViewModel(title: $0, logoName: "") }
        let vc = ItemListVC(listTitle: title, itemViewModels: itemVMs)
        vc.onViewDidLoad = {
            vc.tableView.allowsSelection = false
        }
        
        navigation.pushViewController(vc, animated: true)
    }
}

// MARK: - NextButtonController

private class NextButtonController {
    let button: UIBarButtonItem
    var callback: (() -> Void)?
    
    init(_ button: UIBarButtonItem) {
        self.button = button
        self.setup()
    }
    
    private func setup() {
        button.target = self
        button.action = #selector(fireCallback)
    }
    
    @objc private func fireCallback() {
        callback?()
    }
}
