//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

struct Drink {
    struct Extra {
        let name: String
        let options: [String]
    }
    
    let name: String
    let sizes: [String]
    let extras: [Extra]
}
