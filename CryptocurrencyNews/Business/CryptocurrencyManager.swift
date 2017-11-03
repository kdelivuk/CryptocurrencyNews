//
//  CryptocurrencyManager.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 30/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import RxSwift
import API
import Defines

protocol CryptocurrencyManagerProtocol {
    
    var limitObservable: Observable<Int> { get }
    var fiatCurrencyObservable: Observable<FiatCurrency> { get }
    
    var limit: Int { get }
    var fiatCurrency: FiatCurrency { get }
    
    func top() -> Observable<[Cryptocurrency]>
    func currency(for id: String) -> Observable<Cryptocurrency>
    
    func setLimit(_ newLimit: Int)
    func setFiatCurrency(_ newCurrency: FiatCurrency)
}

class CryptocurrencyManager: CryptocurrencyManagerProtocol {
    
    private struct Constants {
        static let applicationAlreadyLaunched = "applicationAlreadyLaunched"
        static let limitKey = "limitKey"
        static let currencyKey = "currencyKey"
        static let limitDefaultValue = 100
        static let fiatCurrencyDefaultValue = FiatCurrency.usd
    }
    
    var limitObservable: Observable<Int> {
        return self._limit.asObservable()
    }
    
    var fiatCurrencyObservable: Observable<FiatCurrency> {
        return self._fiatCurrency.asObservable()
    }
    
    var limit: Int {
        return _limit.value
    }
    
    var fiatCurrency: FiatCurrency {
        return _fiatCurrency.value
    }
    
    // MARK: - Private properties
    
    private let _limit: Variable<Int>
    private let _fiatCurrency: Variable<FiatCurrency>
    
    private let connector: CryptocurrencyType
    
    // MARK: - Class Lifecycle
    
    init(connector: CryptocurrencyType) {
        self.connector = connector

        // if application is loaded for the first time
        // set default fiat currencies and limit
        if UserDefaults.standard.bool(forKey: Constants.applicationAlreadyLaunched) == false {
            UserDefaults.standard.set(Constants.limitDefaultValue, forKey: Constants.limitKey)
            UserDefaults.standard.set(Constants.fiatCurrencyDefaultValue.rawValue, forKey: Constants.currencyKey)
            UserDefaults.standard.set(true, forKey: Constants.applicationAlreadyLaunched)
            UserDefaults.standard.synchronize()
        }
        
        _limit = Variable(UserDefaults.standard.integer(forKey: Constants.limitKey))
        _fiatCurrency = Variable(FiatCurrency(rawValue: UserDefaults.standard.string(forKey: Constants.currencyKey)!)!)
    }
    
    func top() -> Observable<[Cryptocurrency]> {
        return connector
            .getCryptocurrencies(limit: _limit.value, in: _fiatCurrency.value)
            .map { (result) -> [Cryptocurrency] in
                switch result {
                case .success(let cryptocurrencies):
                    return cryptocurrencies
                case .error(let error):
                    throw error
                }
        }
    }
    
    func currency(for id: String) -> Observable<Cryptocurrency> {
        return connector
            .getCryptocurrency(for: id, in: _fiatCurrency.value)
            .map { (result) -> Cryptocurrency in
                switch result {
                case .success(let cryptocurrency):
                    return cryptocurrency
                case .error(let error):
                    throw error
                }
        }
    }
    
    func setLimit(_ newLimit: Int) {
        if newLimit != _limit.value {
            UserDefaults.standard.set(newLimit, forKey: Constants.limitKey)
            UserDefaults.standard.synchronize()
            _limit.value = newLimit
            print(_limit.value)
        }
    }
    
    func setFiatCurrency(_ newCurrency: FiatCurrency) {
        if newCurrency != _fiatCurrency.value {
            UserDefaults.standard.set(newCurrency.rawValue, forKey: Constants.currencyKey)
            UserDefaults.standard.synchronize()
            _fiatCurrency.value = newCurrency
            print(_fiatCurrency.value)
        }
    }
    
    deinit {
        print("\(self) DEINIT")
    }
}
