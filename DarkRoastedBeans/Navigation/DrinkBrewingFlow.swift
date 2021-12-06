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
        vc.onDidSelectRow = sizeStep
        navigation.pushViewController(vc, animated: true)
    }
    
    func sizeStep() {
        let title = "Select your size"
        let itemVMs = brewingMachineVM.sizes.map { ItemViewModel(title: $0, logoName: "") }
        let vc = ItemListVC(listTitle: title, itemViewModels: itemVMs)
        vc.onDidSelectRow = extrasStep
        navigation.pushViewController(vc, animated: true)
    }
    
    func extrasStep() {
        let title = "Select your extras"
        let itemVMs = brewingMachineVM.extras.map { ItemViewModel(title: $0, logoName: "") }
        let vc = ItemListVC(listTitle: title, itemViewModels: itemVMs)
        navigation.pushViewController(vc, animated: true)
    }
}
