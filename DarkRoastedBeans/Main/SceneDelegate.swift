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

        setNavigationBarAppearance()
        let connectingVM = MachineConnectingVCViewModel(
            companyName: "Dark roasted beans",
            startInstruction: "Tab the machine to start",
            tutorial: "How does this work"
        )
        
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
        }
    }
}
