//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

struct ItemViewModel {
    let title: String
    let logoName: String
}

extension ItemViewModel {
    static func item(from string: String) -> ItemViewModel {
        .init(title: string, logoName: "")
    }
}
