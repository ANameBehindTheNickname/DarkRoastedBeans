//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

struct DummyMachine: BrewingMachine {
    var drinks: [Drink] = [
        .init(name: "Espresso", sizes: ["Small", "Medium", "Large"], extras: []),
        .init(name: "Latte", sizes: ["Medium", "Large"], extras: [
                .init(name: "Sugar", options: ["A lot", "Normal"]),
                .init(name: "Milk", options: ["Dairy", "Soy"])]),
        .init(name: "Coffee 3", sizes: ["Large"], extras: [.init(name: "Milk", options: ["Dairy"])])
    ]
}
