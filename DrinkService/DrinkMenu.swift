//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

public struct DrinkMenu: Decodable {
    public struct DrinkType: Decodable {
        let _id: String
        public let name: String
        public let sizes: [String]
        public let extras: [String]
    }
    
    public struct Size: Decodable {
        public let _id: String
        public let name: String
    }
    
    public struct Extra: Decodable {
        public let _id: String
        public let name: String
        let subselections: [[String: String]]
    }
    
    public let types: [DrinkType]
    public let sizes: [Size]
    public let extras: [Extra]
}
