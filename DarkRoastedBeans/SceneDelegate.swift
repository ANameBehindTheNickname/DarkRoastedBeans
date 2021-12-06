//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let navigation = UINavigationController()
        let brewingMachineVM = BrewingMachineViewModel(
            styles: ["Coffee 1", "Coffee 2", "Coffee 3", "Coffee 4", "Coffee 5"],
            sizes: ["Small", "Medium", "Large"],
            extras: ["Sugar", "Milk"]
        )
        
        let flow = DrinkBrewingFlow(navigation: navigation, brewingMachineVM: brewingMachineVM)
        flow.start()
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}

