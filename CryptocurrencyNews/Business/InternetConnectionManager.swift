//
//  InternetConnectionManager.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 03/11/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

/// Class conforming to this protocol is used for observing the internet connection status
protocol InternetConnectionManagerProtocol: class {
    /// Observable reporting to subscriber of internet connection status changes
    var connectionObservable: Observable<Bool> { get }
    
    /// Read-only Variable containing the last connection satatus value
    var isOnline: Bool { get }
}

final class InternetConnectionManager: InternetConnectionManagerProtocol {
    
    // MARK: - Public properties
    
    let connectionObservable: Observable<Bool>
    private(set) var isOnline: Bool = false
    
    // MARK: - Private properties
    
    private let connectionVariable: Variable<Bool>
    
    static let shared = InternetConnectionManager()
    
    private let manager = NetworkReachabilityManager(host: "www.google.com")
    
    // MARK: - Initialization
    
    private init() {
        
        connectionVariable = Variable(isOnline)
        connectionObservable = connectionVariable.asObservable()
        
        manager?.listenerQueue = DispatchQueue(label: "com.mobileuc.networkreachabilityqueue")
        manager?.listener = { [weak self] status in
            DispatchQueue.main.async {
                switch status {
                case .notReachable, .unknown:
                    self?.isOnline = false
                    self?.connectionVariable.value = false
                case .reachable(_):
                    self?.isOnline = true
                    self?.connectionVariable.value = true
                }
            }
        }
        
        manager?.startListening()
    }
}
