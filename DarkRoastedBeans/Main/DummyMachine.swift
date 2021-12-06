//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

struct DummyMachine: BrewingMachine {
    var drinks = ["Coffee 1", "Coffee 2", "Coffee 3", "Coffee 4", "Coffee 5"]
    var sizes = ["Small", "Medium", "Large"]
    var extras = [Extra(name: "Sugar", options: ["A lot", "Normal"]), Extra(name: "Milk", options: ["Dairy", "Soy", "Oat"])]
}
