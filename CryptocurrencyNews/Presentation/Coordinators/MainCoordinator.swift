//
//  MainCoordinator.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 24/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import UIKit
import SnapKit
import API

final class MainCoordinator: Coordinator {

    fileprivate lazy var tabBarController: UITabBarController = {
        let tabBarController = MainTabBarController()
        return tabBarController
    }()
    
    private let connector = Connector()
        
    lazy var cryptocurrencyManager: CryptocurrencyManagerProtocol = {
        return CryptocurrencyManager(connector: self.connector)
    }()
    
    override func start() {
        openLandingScreen(in: viewController)
    }
    
    fileprivate func openLandingScreen(in viewController: UIViewController) {

        let cryptocurrencyNC = UINavigationController()
        let cryptocurrencyCoordinator = CryptocurrencyCoordinator(in: cryptocurrencyNC, viewController: viewController, cryptocurrencyManager: cryptocurrencyManager)
        push(childCoordinator: cryptocurrencyCoordinator)
        
        let settingsNC = UINavigationController()
        let settingsCoordinator = SettingsCoordinator(in: settingsNC, viewController: viewController, cryptocurrencyManager: cryptocurrencyManager)
        push(childCoordinator: settingsCoordinator)
        
        cryptocurrencyNC.tabBarItem.title = "Cryptocurrency"
        cryptocurrencyNC.tabBarItem.image = Images.iconStock
        
        settingsNC.tabBarItem.title = "Settings"
        settingsNC.tabBarItem.image = Images.iconSettings
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: Color.green], for: .selected)
        
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
