//
//  CryptocurrencyCoordinator.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 25/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import UIKit

final class CryptocurrencyCoordinator: Coordinator {
    
    // MARK: - Private Properties
    
    private let navigationController: UINavigationController
    private let cryptocurrencyManager: CryptocurrencyManagerProtocol
    
    // MARK: - Coordinator Lifecycle
    
    init(in navigationController: UINavigationController, viewController: UIViewController, cryptocurrencyManager: CryptocurrencyManagerProtocol) {
        self.navigationController = navigationController
        self.cryptocurrencyManager = cryptocurrencyManager
        super.init(in: viewController)
    }
    
    deinit {
        print("\(self.objectName) deinit")
    }
    
    // MARK: - Public Methods
    
    override func start() {
        setNewsScreen(in: self.navigationController)
    }
    
    // MARK: - Private Methods
    
    private func setNewsScreen(in navigationController: UINavigationController) {
        let newsVM = NewsVM(cryptocurrencyManager: cryptocurrencyManager)
        let newsVC = NewsVC.instantiateStoryboardVC(viewModel: newsVM)
        
        newsVM.onDidTapItem = { [weak self, unowned navigationController] currency in
            guard let weakself = self else { return }
            weakself.pushInformationScreen(on: navigationController, for: currency)
        }
        
        navigationController.navigationBar.coloured()
        
        navigationController.setViewControllers([newsVC], animated: false)
    }
    
    private func pushInformationScreen(on navigationController: UINavigationController, for currency: Currency) {
        let informationVM = InformationVM(currency: currency, cryptocurrencyManager: self.cryptocurrencyManager)
        let informationVC = InformationVC.instantiateStoryboardVC(viewModel: informationVM)
        
        navigationController.pushViewController(informationVC, animated: true)
    }
}
