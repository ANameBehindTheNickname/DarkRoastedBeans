//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import DrinkService

final class BrewingMachineAdapter: BrewingMachine {
    // MARK: - Public properites
    
    weak var delegate: BrewingMachineDelegate?
    
    // MARK: - Private properites
    
    private let drinkService: DrinkService
    
    // MARK: - Init
    
    init(drinkService: DrinkService) {
        self.drinkService = drinkService
    }
    
    // MARK: - BrewingMachine methods
    
    func getDrinks() {
        drinkService.getDrinkMenu()
    }
}

// MARK: - DrinkServiceDelegate

extension BrewingMachineAdapter: DrinkServiceDelegate {
    func didReceive(_ drinkMenu: DrinkMenu) {
        let drinks: [Drink] = drinkMenu.types.map { type in
            let name = type.name
            
            let sizeIDs = type.sizes
            let extrasIDs = type.extras
            
            let sizes = drinkMenu.sizes.filter { sizeIDs.contains($0._id) }.map { $0.name }
            let drinkMenuExtras = drinkMenu.extras
                .filter { extrasIDs.contains($0._id) }
                .map { $0 }
            
            
            let extras: [Drink.Extra] = drinkMenuExtras.map {
                let options = $0.subselections.compactMap { $0["name"] }
                return Drink.Extra(name: $0.name, options: options)
            }
            
            return Drink(name: name, sizes: sizes, extras: extras)
        }
        
        delegate?.didReceive(drinks)
    }
}
