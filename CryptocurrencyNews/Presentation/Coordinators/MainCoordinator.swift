//
//  MainCoordinator.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 24/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    override func start() {
        setNewsScreen(on: rootNavigationController)
    }
    
    private func setNewsScreen(on navigationController: UINavigationController) {
        let newsVM = NewsVMMock()
        let newsVC = NewsVC.instantiateStoryboardVC(viewModel: newsVM)
        
        newsVM.onDidTapItem = { [weak self, unowned navigationController] _ in
            guard let weakself = self else { return }
            weakself.pushInformationScreen(on: navigationController)
        }
        
        navigationController.setViewControllers([newsVC], animated: false)
    }
    
    private func pushInformationScreen(on navigationController: UINavigationController) {
        let informationVM = InformationVM()
        let informationVC = InformationVC.instantiateStoryboardVC(viewModel: informationVM)
        
        navigationController.pushViewController(informationVC, animated: true)
    }
}
