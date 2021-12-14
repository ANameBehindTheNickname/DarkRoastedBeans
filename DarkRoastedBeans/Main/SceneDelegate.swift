//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit
import DrinkService

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private lazy var navigation = UINavigationController()
    private let connectingVM = MachineConnectingVCViewModel(
        companyName: "Dark roasted beans",
        startInstruction: "Tap the screen to connect",
        tutorial: "How does this work"
    )
    
    private lazy var connectingVC = MachineConnectingVC(viewModel: connectingVM)

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        setNavigationBarAppearance()
        
        let session = URLSession(configuration: .default)
        let drinkService = DarkRoastedBeansRemoteService(session: session)
        let brewingMachine = BrewingMachineAdapter(drinkService: drinkService)
        drinkService.delegate = brewingMachine
        brewingMachine.delegate = self
        
        connectingVC.onConnect = { [unowned self] in
            navigation.modalPresentationStyle = .fullScreen
            brewingMachine.getDrinks()
        }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = connectingVC
        window?.makeKeyAndVisible()
    }
    
    private func setNavigationBarAppearance() {
        let appearance = UINavigationBar.appearance()
        appearance.barTintColor = .white
        appearance.isTranslucent = false
        appearance.shadowImage = UIImage()
        appearance.titleTextAttributes = [.font: UIFont(name: "AvenirNext-Bold", size: 16)!]
        appearance.tintColor = .black
        appearance.backIndicatorImage = .init(named: "back_indicator")
        appearance.backIndicatorTransitionMaskImage = .init(named: "back_indicator")
    }
}

// MARK: - BrewingMachineDelegate

extension SceneDelegate: BrewingMachineDelegate {
    func didReceive(_ drinks: [Drink]) {
        let flow = DrinkBrewingFlow(navigation: navigation, drinks: drinks)
        DispatchQueue.main.async {
            flow.start()
            self.connectingVC.showDetailViewController(self.navigation, sender: self.connectingVC)
        }
    }
}
