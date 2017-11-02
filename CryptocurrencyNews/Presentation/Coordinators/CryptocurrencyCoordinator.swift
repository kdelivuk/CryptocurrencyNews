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
    private let cryptocurrencyManager: CryptocurrencyManager
    
    // MARK: - Coordinator Lifecycle
    
    init(in navigationController: UINavigationController, viewController: UIViewController, cryptocurrencyManager: CryptocurrencyManager) {
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
        
        newsVM.onDidTapItem = { [weak self, unowned navigationController] _ in
            guard let weakself = self else { return }
            weakself.pushInformationScreen(on: navigationController)
        }
        
        navigationController.navigationBar.coloured()
        
        navigationController.setViewControllers([newsVC], animated: false)
    }
    
    private func pushInformationScreen(on navigationController: UINavigationController) {
        let informationVM = InformationVM()
        let informationVC = InformationVC.instantiateStoryboardVC(viewModel: informationVM)
        
        navigationController.pushViewController(informationVC, animated: true)
    }
}
