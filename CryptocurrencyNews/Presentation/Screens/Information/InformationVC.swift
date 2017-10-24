//
//  InformationVC.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 23/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import UIKit

class InformationVC: UIViewController {
    
    private var mainView: InformationView { return view as! InformationView }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}


extension InformationVC: StoryboardCompatible {
    typealias T = InformationVMProtocol
}
