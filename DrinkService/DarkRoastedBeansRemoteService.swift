//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import Foundation

public final class DarkRoastedBeansRemoteService: DrinkService {
    // MARK: - Public properites
    
    public weak var delegate: DrinkServiceDelegate?
    
    // MARK: - Private properites
    
    private let session: URLSession
    
    // MARK: - Init
    
    public init(session: URLSession) {
        self.session = session
    }
    
    // MARK: - DrinkService methods
    
    public func getDrinkMenu() {
        let url = URL(string: "https://darkroastedbeans.coffeeit.nl/coffee-machine/60ba1ab72e35f2d9c786c610")!
        session.dataTask(with: url) { data, _, _ in
            guard let data = data,
                  let drinkMenu = try? JSONDecoder().decode(DrinkMenu.self, from: data) else { return }
            
            self.delegate?.didReceive(drinkMenu)
        }.resume()
    }
}
