//
//  SettingsVC.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 25/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    private var mainView: SettingsView { return view as! SettingsView }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}


extension SettingsVC: StoryboardCompatible {
    typealias T = SettingsVMProtocol
}
