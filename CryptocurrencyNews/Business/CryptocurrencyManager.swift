//
//  CryptocurrencyManager.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 30/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import RxSwift
import API

protocol CryptocurrencyManagerProtocol {
    func search() -> Observable<[Cryptocurrency]>
}

class CryptocurrencyManager {
    
    private let connector: CryptocurrencyType
    
    init(connector: CryptocurrencyType) {
        self.connector = connector
    }
    
    func search() -> Observable<[Cryptocurrency]> {
        
        let limit = 100
        let currency = API.Currency.cad
        
        return connector
            .getCryptocurrencies(limit: limit, in: currency)
            .map { (result) -> [Cryptocurrency] in
                switch result {
                case .success(let cryptocurrencies):
                    return cryptocurrencies
                case .error(let error):
                    throw error
                }
        }
    }
    
}
