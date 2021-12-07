//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private lazy var navigation = UINavigationController()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let connectingVM = MachineConnectingVCViewModel(companyName: "Dark roasted beans", startInstruction: "Tab the machine to start")
        let connectingVC = MachineConnectingVC(viewModel: connectingVM)
        let brewingMachine = DummyMachine()
        brewingMachine.delegate = self
        
        connectingVC.onViewDidLoad = { [unowned self] in
            navigation.modalPresentationStyle = .fullScreen
            connectingVC.showDetailViewController(navigation, sender: connectingVC)
            brewingMachine.getDrinks()
        }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = connectingVC
        window?.makeKeyAndVisible()
    }
}

// MARK: - BrewingMachineDelegate

extension SceneDelegate: BrewingMachineDelegate {
    func didReceive(_ drinks: [Drink]) {
        let flow = DrinkBrewingFlow(navigation: navigation, drinks: drinks)
        DispatchQueue.main.async {
            flow.start()
        }
    }
}
