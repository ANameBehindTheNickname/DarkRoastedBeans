//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let machineVM = MachineVCViewModel(companyName: "Dark roasted beans", startInstruction: "Tab the machine to start")
        let machineVC = MachineVC(viewModel: machineVM)
        let navigation = UINavigationController()
        let brewingMachineVM = BrewingMachineViewModel(
            styles: ["Coffee 1", "Coffee 2", "Coffee 3", "Coffee 4", "Coffee 5"],
            sizes: ["Small", "Medium", "Large"],
            extras: ["Sugar", "Milk"]
        )
        
        let flow = DrinkBrewingFlow(navigation: navigation, brewingMachineVM: brewingMachineVM)
        machineVC.onViewDidLoad = {
            navigation.modalPresentationStyle = .fullScreen
            machineVC.showDetailViewController(navigation, sender: machineVC)
            flow.start()
        }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = machineVC
        window?.makeKeyAndVisible()
    }
}

