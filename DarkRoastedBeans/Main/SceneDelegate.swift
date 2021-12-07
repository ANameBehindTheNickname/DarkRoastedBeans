//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let connectingVM = MachineConnectingVCViewModel(companyName: "Dark roasted beans", startInstruction: "Tab the machine to start")
        let connectingVC = MachineConnectingVC(viewModel: connectingVM)
        let navigation = UINavigationController()
        let brewingMachine = DummyMachine()
        
        let flow = DrinkBrewingFlow(navigation: navigation, brewingMachine: brewingMachine)
        connectingVC.onViewDidLoad = {
            navigation.modalPresentationStyle = .fullScreen
            connectingVC.showDetailViewController(navigation, sender: connectingVC)
            flow.start()
        }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = connectingVC
        window?.makeKeyAndVisible()
    }
}

