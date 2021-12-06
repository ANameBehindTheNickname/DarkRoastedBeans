//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

struct BrewingMachineViewModel {
    let styles: [String]
    let sizes: [String]
    let extras: [String]
}

final class DrinkBrewingFlow {
    private let navigation: UINavigationController
    private let brewingMachineVM: BrewingMachineViewModel
    
    init(navigation: UINavigationController, brewingMachineVM: BrewingMachineViewModel) {
        self.navigation = navigation
        self.brewingMachineVM = brewingMachineVM
    }
    
    func start() {
        let title = "Select your style"
        let itemVMs = brewingMachineVM.styles.map { ItemViewModel(title: $0, logoName: "") }
        let vc = ItemListVC(listTitle: title, itemViewModels: itemVMs)
        vc.onDidSelectRow = styleStepCompleted
        navigation.pushViewController(vc, animated: true)
    }
    
    func styleStepCompleted(styleRow: Int) {
        let title = "Select your size"
        let itemVMs = brewingMachineVM.sizes.map { ItemViewModel(title: $0, logoName: "") }
        let vc = ItemListVC(listTitle: title, itemViewModels: itemVMs)
        vc.onDidSelectRow = { [weak self] in
            self?.sizeStepCompleted(styleRow: styleRow, sizeRow: $0)
        }
        
        navigation.pushViewController(vc, animated: true)
    }
    
    func sizeStepCompleted(styleRow: Int, sizeRow: Int) {
        let title = "Select your extras"
        let itemVMs = brewingMachineVM.extras.map { ItemViewModel(title: $0, logoName: "") }
        let vc = ItemListVC(listTitle: title, itemViewModels: itemVMs)
        vc.onDidSelectRow = { [weak self] in
            self?.extrasStepCompleted(styleRow: styleRow, sizeRow: sizeRow, extrasRow: $0)
        }
        
        navigation.pushViewController(vc, animated: true)
    }
    
    func extrasStepCompleted(styleRow: Int, sizeRow: Int, extrasRow: Int) {
        let title = "Overview"
        let style = brewingMachineVM.styles[styleRow]
        let size = brewingMachineVM.sizes[sizeRow]
        let extras = brewingMachineVM.extras[extrasRow]
        let itemVMs = [style, size, extras].map { ItemViewModel(title: $0, logoName: "") }
        let vc = ItemListVC(listTitle: title, itemViewModels: itemVMs)
        navigation.pushViewController(vc, animated: true)
    }
}
