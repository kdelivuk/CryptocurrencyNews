//
//  UIViewController+Extension.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 25/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import UIKit

extension UIViewController {
    func attachChildVC(_ childVC: UIViewController) {
        attachChildVC(childVC, parentView: self.view)
    }

    func attachChildVC(_ childVC: UIViewController, parentView: UIView) {
        addChildViewController(childVC)
        parentView.addSubview(childVC.view)
        childVC.didMove(toParentViewController: self)
    }
    
    func removeChildVCFromParentViewController() {
        view.removeFromSuperview()
        removeFromParentViewController()
        didMove(toParentViewController: nil)
    }
}
