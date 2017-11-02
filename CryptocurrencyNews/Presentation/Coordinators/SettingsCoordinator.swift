//
//  SettingsCoordinator.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 25/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import UIKit

final class SettingsCoordinator: Coordinator {
    
    // MARK: - Private Properties
    
    private let navigationController: UINavigationController
    private let cryptocurrencyManager: CryptocurrencyManager
    
    // MARK: - Coordinator Lifecycle
    
    init(in navigationController: UINavigationController, viewController: UIViewController, cryptocurrencyManager: CryptocurrencyManager) {
        self.cryptocurrencyManager = cryptocurrencyManager
        self.navigationController = navigationController
        super.init(in: viewController)
    }
    
    deinit {
        print("\(self.objectName) deinit")
    }
    
    // MARK: - Public Methods
    
    override func start() {
        setSettingsScreen(in: self.navigationController)
    }
    
    // MARK: - Private Methods
    
    private func setSettingsScreen(in navigationController: UINavigationController) {
        let settingsVM = SettingsVM(cryptocurrencyManager: cryptocurrencyManager)
        let settingsVC = SettingsVC.instantiateStoryboardVC(viewModel: settingsVM)
    
        navigationController.navigationBar.coloured()
        
        navigationController.setViewControllers([settingsVC], animated: false)
    }
}
