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
        
        let brewButtonVC = BrewButtonVC()
        brewButtonVC.onBrew = { print("Brew some drink") }
        let overviewVC = OverviewContainerVC(itemListVC: vc, brewButtonVC: brewButtonVC)
        
        navigation.pushViewController(overviewVC, animated: true)
    }
}

// MARK: - MainContainerVC

final private class OverviewContainerVC: UIViewController {
    // MARK: - Private properites
    
    private let itemListVC: UIViewController
    private let brewButtonVC: UIViewController
    
    // MARK: - Init
    
    init(itemListVC: UIViewController, brewButtonVC: UIViewController) {
        self.itemListVC = itemListVC
        self.brewButtonVC = brewButtonVC
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [itemListVC, brewButtonVC].forEach { addChildVC($0) }
        constraintSubviews()
    }
    
    // MARK: - Private methods
    
    private func addChildVC(_ childController: UIViewController) {
        addChild(childController)
        view.addSubview(childController.view)
        childController.didMove(toParent: self)
    }
    
    private func constraintSubviews() {
        itemListVC.view.translatesAutoresizingMaskIntoConstraints = false
        brewButtonVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemListVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            itemListVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            itemListVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            itemListVC.view.bottomAnchor.constraint(equalTo: brewButtonVC.view.topAnchor),
            
            brewButtonVC.view.heightAnchor.constraint(equalToConstant: 100),
            brewButtonVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            brewButtonVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            brewButtonVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// MARK: - NextButtonController

final private class NextButtonController {
    // MARK: - Subviews
    
    let button: UIBarButtonItem
    
    // MARK: - Public properties
    
    var callback: (() -> Void)?
    
    // MARK: - Init
    
    init(_ button: UIBarButtonItem) {
        self.button = button
        self.setup()
    }
    
    // MARK: - Private methods
    
    private func setup() {
        button.target = self
        button.action = #selector(fireCallback)
    }
    
    @objc private func fireCallback() {
        callback?()
    }
}
