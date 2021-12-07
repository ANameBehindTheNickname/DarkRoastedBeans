//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

public struct DrinkMenu: Decodable {
    public struct DrinkType: Decodable {
        let _id: String
        let name: String
        let sizes: [String]
        let extras: [String]
    }
    
    public struct Size: Decodable {
        let _id: String
        let name: String
    }
    
    public struct Extra: Decodable {
        let _id: String
        let name: String
        let subselections: [[String: String]]
    }
    
    public let types: [DrinkType]
    public let sizes: [Size]
    public let extras: [Extra]
}
