//
//  CryptocurrencyManagerMock.swift
//  CryptocurrencyNewsTests
//
//  Created by Kristijan Delivuk on 06/11/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import XCTest
import RxSwift
@testable import Defines
@testable import API
@testable import CryptocurrencyNews

class CryptocurrencyManagerMock: CryptocurrencyManagerProtocol {
    
    var limitObservable: Observable<Int> {
        return Observable<Int>.empty()
    }
    var fiatCurrencyObservable: Observable<FiatCurrency> {
        return Observable<FiatCurrency>.empty()
    }
    
    var limit: Int {
        return 100
    }
    
    var fiatCurrency: FiatCurrency {
        return FiatCurrency.usd
    }
    
    func top() -> Observable<[Cryptocurrency]> {
        return Observable<[Cryptocurrency]>.empty()
    }
    
    func currency(for id: String) -> Observable<Cryptocurrency> {
        return Observable<Cryptocurrency>.empty()
    }
    
    func setLimit(_ newLimit: Int) {
        
    }
    
    func setFiatCurrency(_ newCurrency: FiatCurrency) {
        
    }
}
