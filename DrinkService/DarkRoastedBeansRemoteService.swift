//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import Foundation

public final class DarkRoastedBeansRemoteService: DrinkService {
    weak var delegate: DrinkServiceDelegate?
    private let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    public func getDrinkMenu() {
        let url = URL(string: "https://darkroastedbeans.coffeeit.nl/coffee-machine/60ba1ab72e35f2d9c786c610")!
        session.dataTask(with: url) { data, _, _ in
            guard let data = data,
                  let drinkMenu = try? JSONDecoder().decode(DrinkMenu.self, from: data) else { return }
            
            self.delegate?.didReceive(drinkMenu)
        }.resume()
    }
}
