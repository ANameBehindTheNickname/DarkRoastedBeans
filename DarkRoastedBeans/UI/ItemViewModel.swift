//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

struct ItemViewModel {
    let title: String
    let logoName: String
}

// MARK: - Drink mapping

extension ItemViewModel {
    static func item(from string: String) -> ItemViewModel {
        .init(title: string, logoName: "")
    }
    
    static func drinkItem(from drink: Drink) -> ItemViewModel {
        .init(title: drink.name, logoName: "Type/\(drink.name.lowercased())")
    }
    
    static func sizeItem(from size: String) -> ItemViewModel {
        .init(title: size, logoName: "Size/\(size.lowercased())")
    }
    
    static func extraItem(from extra: Drink.Extra) -> ItemViewModel {
        .init(title: extra.name, logoName: "Extra/\(extra.name.lowercased())")
    }
    
    static func drinkTypeItems(from drinks: [Drink]) -> [ItemViewModel] {
        drinks.map(drinkItem)
    }
    
    static func sizeItems(from drink: Drink) -> [ItemViewModel] {
        drink.sizes.map(sizeItem)
    }
    
    static func extraItems(from drink: Drink) -> [ItemViewModel] {
        drink.extras.map(extraItem)
    }
}
