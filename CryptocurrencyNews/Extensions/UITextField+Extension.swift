//
//  UITextField+Extension.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 31/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setBottomBorder(borderColor: UIColor) {
        
        borderStyle = UITextBorderStyle.none
        backgroundColor = UIColor.clear
        
        let height = 1.0
        
        let bottomView = UIView()
        bottomView.backgroundColor = borderColor
        bottomView.frame = CGRect(x: 0, y: Double(self.frame.height) - height, width: Double(self.frame.width), height: height)
    
        addSubview(bottomView)
    }
}
