//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class DrinkBrewingFlow {
    // MARK: - Private properites
    
    private let navigation: UINavigationController
    private let drinks: [Drink]
    
    private lazy var buttonController: BarButtonController = {
        let button = UIBarButtonItem(title: "Next", style: .plain, target: nil, action: nil)
        [UIControl.State.normal, .highlighted].forEach {
            button.setTitleTextAttributes([.font: UIFont(name: "AvenirNext-Medium", size: 16)!], for: $0)
        }
        
        return .init(button)
    }()
    
    // MARK: - Init
    
    init(navigation: UINavigationController, drinks: [Drink]) {
        self.navigation = navigation
        self.drinks = drinks
    }
    
    // MARK: - Public methods
    
    func start() {
        let title = "Select your style"
        let itemVMs = ItemViewModel.drinkTypeItems(from: drinks)
        let vc = ItemListVC(listTitle: title, itemViewModels: itemVMs)
        vc.onDidSelectRow = styleStepCompleted
        navigation.pushViewController(vc, animated: false)
    }
    
    // MARK: - Private methods
    
    private func styleStepCompleted(styleRow: Int) {
        let title = "Select your size"
        let drink = drinks[styleRow]
        let itemVMs = ItemViewModel.sizeItems(from: drink)
        let vc = ItemListVC(listTitle: title, itemViewModels: itemVMs)
        vc.onDidSelectRow = { [weak self] in
            self?.sizeStepCompleted(styleRow: styleRow, sizeRow: $0)
        }

        navigation.pushViewController(vc, animated: true)
    }
    
    private func sizeStepCompleted(styleRow: Int, sizeRow: Int) {
        let title = "Select your extras"
        let drink = drinks[styleRow]
        let itemVMs = ItemViewModel.extraItems(from: drink)
        let vc = ItemListVC(listTitle: title, itemViewModels: itemVMs)
        vc.onViewDidLoad = {
            vc.tableView.allowsMultipleSelection = true
        }
        
        vc.onDidSelectRow = {
            let options = drink.extras[$0].options.map { ($0, "unchecked_circle") }
            let checkItemConfigs = options.map(ItemViewModel.item).map(CheckingItemConfiguration.init)
            let tableConfig = TableConfiguration(tableItemConfigs: checkItemConfigs)
            
            let itemListCell = vc.tableView.cellForRow(at: .init(row: $0, section: 0))
            itemListCell?.contentConfiguration = ExpandedItemConfiguration(
                itemConfiguration: .init(viewModel: itemVMs[$0], isLineViewHidden: false),
                tableConfiguration: tableConfig
            )
        }
        
        vc.onDidDeselectRow = {
            let itemListCell = vc.tableView.cellForRow(at: .init(row: $0, section: 0))
            itemListCell?.contentConfiguration = ItemConfiguration(viewModel: itemVMs[$0], isLineViewHidden: true)
        }

        buttonController.callback = { [weak self] in
            let extraIndexPaths = (0 ..< drink.extras.count).map { IndexPath(row: $0, section: 0) }
            let selectedExtras = extraIndexPaths.reduce([Drink.Extra]()) { acc, indexPath in
                let itemCell = vc.tableView.cellForRow(at: indexPath)
                guard let expandedConfig = itemCell?.contentConfiguration as? ExpandedItemConfiguration else { return acc }
                
                if let selectedRow = expandedConfig.tableConfiguration.selectedSubitemRow {
                    let oldExtra = drink.extras[indexPath.row]
                    return acc + [Drink.Extra(name: oldExtra.name, options: [oldExtra.options[selectedRow]])]
                }
                
                return acc
            }
            
            self?.extrasStepCompleted(styleRow: styleRow, sizeRow: sizeRow, selectedExtras: selectedExtras)
        }

        vc.navigationItem.rightBarButtonItem = buttonController.button
        navigation.pushViewController(vc, animated: true)
    }
    
    private func extrasStepCompleted(styleRow: Int, sizeRow: Int, selectedExtras: [Drink.Extra]) {
        let title = "Overview"
        
        let drink = drinks[styleRow]
        let size = drink.sizes[sizeRow]
        let extraSubitems = selectedExtras.flatMap { $0.options }
        let itemVMs: [ItemViewModel] = [
            .drinkItem(from: drink),
            .sizeItem(from: size)
        ] + selectedExtras.map(ItemViewModel.extraItem)
        
        // TODO: - "unchecked_circle" just to compile. Change later
        let extraSubitemsVMs = extraSubitems.map { ($0, "unchecked_circle") }.map(ItemViewModel.item)
        let vc = ItemListVC(listTitle: title, itemViewModels: itemVMs + extraSubitemsVMs)
        vc.onViewDidLoad = {
            vc.tableView.allowsSelection = false
        }

        let brewButtonVC = BrewButtonVC()
        brewButtonVC.onBrew = { print("Brew some drink") }
        let overviewVC = OverviewContainerVC(itemListVC: vc, brewButtonVC: brewButtonVC)
        overviewVC.navigationItem.title = "Brew with Lex"

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

// MARK: - BarButtonController

final private class BarButtonController {
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
