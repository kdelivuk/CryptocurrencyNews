//
//  StoryboardComplatible.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 23/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import Foundation

import UIKit

protocol StoryboardCompatible: class {
    
    associatedtype T
    
}

private var viewModelKey = "ViewController.viewmodel"

extension StoryboardCompatible where Self: UIViewController{
    
    var viewModel: T {
        get {
            return objc_getAssociatedObject(self, &viewModelKey) as! Self.T
        }
        set {
            objc_setAssociatedObject(self, &viewModelKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    static func instantiateStoryboardVC(viewModel: T) -> Self {
        let identifier = NSStringFromClass(Self.self).components(separatedBy: ".").last!
        let vc = UIStoryboard(name: identifier, bundle: nil).instantiateViewController(withIdentifier: identifier) as! Self
        vc.viewModel = viewModel
        return vc
    }
    
}
