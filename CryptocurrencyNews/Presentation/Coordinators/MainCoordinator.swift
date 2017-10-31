//
//  MainCoordinator.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 24/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import UIKit
import SnapKit

final class MainCoordinator: Coordinator {

    fileprivate lazy var tabBarController: UITabBarController = {
        let tabBarController = MainTabBarController()
        return tabBarController
    }()
    
    override func start() {
        openLandingScreen(in: viewController)
    }
    
    fileprivate func openLandingScreen(in viewController: UIViewController) {
        let cryptocurrencyNC = UINavigationController()
        let cryptocurrencyCoordinator = CryptocurrencyCoordinator(in: cryptocurrencyNC, viewController: viewController)
        push(childCoordinator: cryptocurrencyCoordinator)
        
        let settingsNC = UINavigationController()
        let settingsCoordinator = SettingsCoordinator(in: settingsNC, viewController: viewController)
        push(childCoordinator: settingsCoordinator)
        
        cryptocurrencyNC.tabBarItem.title = "Cryptocurrency"
        cryptocurrencyNC.tabBarItem.image = Images.iconStock
//        cryptocurrencyNC.tabBarItem.selectedImage =
        
        settingsNC.tabBarItem.title = "Settings"
        settingsNC.tabBarItem.image = Images.iconSettings
//        settingsNC.tabBarItem.selectedImage =
        
//        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: Colors.general], for: .selected)
        
        tabBarController.setViewControllers([cryptocurrencyNC, settingsNC], animated: false)
        
        viewController.attachChildVC(tabBarController)
        
        tabBarController.view.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
    func coordinatorWillBeRemoved() {
        tabBarController.presentedViewController?.dismiss(animated: false, completion: nil)
        tabBarController.removeChildVCFromParentViewController()
    }
    
    deinit {
        print("\(self.objectName) deinit")
    }
}
