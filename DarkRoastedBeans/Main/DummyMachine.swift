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
                    .init(name: "Milk", options: ["Dairy", "Soy", "Oat"])]),
            Drink(name: "Lungo", sizes: ["Large"], extras: [.init(name: "Milk", options: ["Dairy"])]),
            Drink(name: "Cappuccino", sizes: ["Small", "Large"], extras: [.init(name: "Milk", options: ["Oat", "Dairy"])])
        ]
        
        delegate?.didReceive(drinks)
    }
}
