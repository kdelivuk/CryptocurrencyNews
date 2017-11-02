//
//  SettingsVM.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 25/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import RxSwift
import Defines

final class SettingsVM: SettingsVMProtocol {
    
    // MARK: - Public properties
    
    var title: String {
        return NSLocalizedString("Settings", comment: "SettingsVM.title")
    }
    
    var headerTitle: String {
        return NSLocalizedString("Define entries", comment: "SettingsVM.headerTitle")
    }
    
    var limitResultsTitle: String {
        return NSLocalizedString("Limit results", comment: "SettingsVM.limitResultsTitle")
    }
    
    var fiatCurrencyTitle: String {
        return NSLocalizedString("Fiat curreny", comment: "SettingsVM.fiatCurrencyTitle")
    }
    
    var footerTitle: String {
        return NSLocalizedString("Note: Entries are automatically saved when changed", comment: "SettingsVM.headerTitle")
    }
    
    var numberOfItems: Int {
        return items.count
    }
    
    let currencies: [FiatCurrency]
    let items: [SettingsVMItem]
    
    let initialFiatCurrency: FiatCurrency
    
    lazy var selectedCurrencyObservable: Observable<FiatCurrency> = {
        return self._selectedCurrency.asObservable()
    }()
    
    lazy var limitObservable: Observable<Int> = {
        return self._limit.asObservable()
    }()
    
    private var _selectedCurrency: Variable<FiatCurrency>
    private var _limit: Variable<Int>
    
    private let cryptocurrencyManager: CryptocurrencyManager
    private let disposeBag: DisposeBag
    
    // MARK: - Class lifecycle
    
    init(cryptocurrencyManager: CryptocurrencyManager) {
        self.cryptocurrencyManager = cryptocurrencyManager
        self.initialFiatCurrency = cryptocurrencyManager.fiatCurrency
        
        _selectedCurrency = Variable(cryptocurrencyManager.fiatCurrency)
        _limit = Variable(cryptocurrencyManager.limit)
        disposeBag = DisposeBag()
        
        items = [.limit, .fiat]
        
        currencies = [
            Defines.FiatCurrency.eur,
            Defines.FiatCurrency.usd,
            Defines.FiatCurrency.cny
        ]
        
        cryptocurrencyManager
            .fiatCurrencyObservable
            .subscribe(onNext: { (currency) in
                self._selectedCurrency.value = currency
            }).disposed(by: disposeBag)
        
        cryptocurrencyManager
            .limitObservable
            .subscribe(onNext: { (limit) in
                self._limit.value = limit
            }).disposed(by: disposeBag)
    }
    
    // MARK: - Public methods
    
    func item(for indexPath: IndexPath) -> SettingsVMItem {
        return items[indexPath.row]
    }

    func changeLimit(to limit: String) {
        guard let limitNumber = Int(limit) else { return }
        cryptocurrencyManager.setLimit(limitNumber)
    }
    
    func selectCurrency(at row: Int) {
        cryptocurrencyManager.setFiatCurrency(currencies[row])
    }
}
