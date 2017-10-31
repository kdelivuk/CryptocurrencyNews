//
//  MainTabBarController.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 31/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - Class lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        // Configure appearance
    
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: Fonts.regular(size: 12)], for: .normal)
        
        tabBar.barTintColor = Color.white
        tabBar.tintColor = Color.main
        tabBar.backgroundColor = Color.white.withAlphaComponent(0.1)
        tabBar.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.1).cgColor
        tabBar.clipsToBounds = true
        tabBar.layer.borderWidth = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
