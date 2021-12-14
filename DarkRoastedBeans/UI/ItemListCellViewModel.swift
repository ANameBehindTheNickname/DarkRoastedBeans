//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

final class ItemListCellViewModel {
    let mainItem: ItemViewModel
    let subitems: [ItemViewModel]
    
    var selectedSubitemRow: Int?
    
    init(mainItem: ItemViewModel, subitems: [ItemViewModel]) {
        self.mainItem = mainItem
        self.subitems = subitems
    }
}
