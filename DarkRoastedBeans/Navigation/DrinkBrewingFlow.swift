//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class DrinkBrewingFlow {
    // MARK: - Private properites
    
    private let navigation: UINavigationController
    private let drinks: [Drink]
    
    private lazy var buttonController: NextButtonController = {
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
        let drinksWithLogos = drinks.reduce([(String, String)]()) { acc, drink in
            acc + [(drink.name, "Type/\(drink.name.lowercased())")]
        }
        
        let itemVMs = drinksWithLogos.map(ItemViewModel.item).map { ItemListCellViewModel(mainItem: $0, subitems: []) }
        let vc = ItemListVC(listTitle: title, itemViewModels: itemVMs)
        vc.onDidSelectRow = styleStepCompleted
        navigation.pushViewController(vc, animated: false)
    }
    
    // MARK: - Private methods
    
    private func styleStepCompleted(styleRow: Int) {
        let title = "Select your size"
        let drink = drinks[styleRow]
        let sizesWithLogos = drink.sizes.reduce([(String, String)]()) { acc, sizeName in
            acc + [(sizeName, "Size/\(sizeName.lowercased())")]
        }
        
        let itemVMs = sizesWithLogos.map(ItemViewModel.item).map { ItemListCellViewModel(mainItem: $0, subitems: []) }
        let vc = ItemListVC(listTitle: title, itemViewModels: itemVMs)
        vc.onDidSelectRow = { [weak self] in
            self?.sizeStepCompleted(styleRow: styleRow, sizeRow: $0)
        }

        navigation.pushViewController(vc, animated: true)
    }
    
    private func sizeStepCompleted(styleRow: Int, sizeRow: Int) {
        let title = "Select your extras"
        let drink = drinks[styleRow]
        
        let itemVMs = drink.extras.map { extra in
            ItemListCellViewModel(
                mainItem: .init(title: extra.name, logoName: "Extra/\(extra.name.lowercased())"),
                subitems: extra.options.map { .init(title: $0, logoName: "unchecked_circle") }
            )
        }
        
        let vc = ItemListVC(listTitle: title, itemViewModels: itemVMs)
        vc.onViewDidLoad = {
            vc.tableView.allowsMultipleSelection = true
        }
        
        vc.onDidSelectRow = {
            let itemListCell = vc.tableView.cellForRow(at: .init(row: $0, section: 0)) as? ItemListCell
            itemListCell?.expandSubitems()
        }
        
        vc.onDidDeselectRow = {
            let itemListCell = vc.tableView.cellForRow(at: .init(row: $0, section: 0)) as? ItemListCell
            itemListCell?.collapseSubitems()
        }

        buttonController.callback = { [weak self] in
            let selectedExtraRows = itemVMs.enumerated().reduce([(Int, Int)]()) { acc, element in
                let (extraRow, extraVM) = element
                if let selectedOptionRow = extraVM.selectedSubitemRow {
                    return acc + [(extraRow, selectedOptionRow)]
                }
                
                return acc
            }
            
            self?.extrasStepCompleted(styleRow: styleRow, sizeRow: sizeRow, selectedExtraRows: selectedExtraRows)
        }

        vc.navigationItem.rightBarButtonItem = buttonController.button
        navigation.pushViewController(vc, animated: true)
    }
    
    private func extrasStepCompleted(styleRow: Int, sizeRow: Int, selectedExtraRows: [(extraRow: Int, optionRow: Int)]) {
        let title = "Overview"
        let drink = drinks[styleRow]
        
        let drinkName = drink.name
        let drinkVM = ItemListCellViewModel(
            mainItem: .init(title: drinkName, logoName: "Type/\(drinkName.lowercased())"),
            subitems: []
        )
        
        let sizeName = drink.sizes[sizeRow]
        let sizeVM = ItemListCellViewModel(
            mainItem: .init(title: sizeName, logoName: "Size/\(sizeName.lowercased())"),
            subitems: [])
        
        let extraVMs: [ItemListCellViewModel] = selectedExtraRows.map {
            let extra = drink.extras[$0.extraRow]
            let option = extra.options[$0.optionRow]
            let vm = ItemListCellViewModel(
                mainItem: .init(title: extra.name, logoName: "Extra/\(extra.name.lowercased())"),
                subitems: [.init(title: option, logoName: "checked_circle")]
            )
            
            vm.selectedSubitemRow = 0
            return vm
        }
        
        let vc = ItemListVC(listTitle: title, itemViewModels: [drinkVM, sizeVM] + extraVMs)
        vc.onViewDidLoad = {
            vc.tableView.allowsSelection = false
        }

        let brewButtonVC = BrewButtonVC(buttonTitle: "Brew your coffee")
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
            itemListVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            brewButtonVC.view.heightAnchor.constraint(equalToConstant: 206),
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
