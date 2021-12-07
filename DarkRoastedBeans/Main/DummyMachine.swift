//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

final class DummyMachine: BrewingMachine {
    weak var delegate: BrewingMachineDelegate?
    
    func getDrinks() {
        let drinks = [
            Drink(name: "Espresso", sizes: ["Small", "Medium", "Large"], extras: []),
            Drink(name: "Latte", sizes: ["Medium", "Large"], extras: [
                    .init(name: "Sugar", options: ["A lot", "Normal"]),
                    .init(name: "Milk", options: ["Dairy", "Soy"])]),
            Drink(name: "Coffee 3", sizes: ["Large"], extras: [.init(name: "Milk", options: ["Dairy"])])
        ]
        
        delegate?.didReceive(drinks)
    }
}
