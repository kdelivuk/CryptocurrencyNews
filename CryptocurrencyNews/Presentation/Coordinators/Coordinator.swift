//
//  Coordinator.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 23/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import UIKit

class Coordinator: NSObject {
    
    let viewController: UIViewController
    
    var shouldEnd: (() -> Void)?
    
    private(set) var coordinators = [Coordinator]()
    
    init(in viewController: UIViewController) {
        self.viewController = viewController
        self.coordinators = []
    }
    
    func push(childCoordinator: Coordinator) {
        coordinators.append(childCoordinator)
        childCoordinator.start()
    }
    
    @discardableResult
    func pop(childCoordinator: Coordinator) -> Coordinator? {
        if let index = coordinators.index(of: childCoordinator) {
            childCoordinator.coordinatorWillEnd()
            return coordinators.remove(at: index)
        } else {
            return nil
        }
    }
    
    func start() {
        // To be overriden
    }
    
    
    /// This method will be called before coordinator is removed from the stack.
    /// Use this method to clean view hierarchy
    func coordinatorWillEnd() {
        
    }
}
