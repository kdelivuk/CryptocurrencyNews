//
//  UINavigationBar+Extension.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 31/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    func coloured() {
        
        backgroundColor = Color.white.withAlphaComponent(0.1)
        barTintColor = Color.white
        tintColor = Color.main
        shadowImage = UIImage()
        setBackgroundImage(UIImage(), for: .default)
        isTranslucent = false
        isOpaque = false
        
        titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: Color.black,
            NSAttributedStringKey.font: Fonts.regular(size: 18)
        ]
    }
    
    
}

