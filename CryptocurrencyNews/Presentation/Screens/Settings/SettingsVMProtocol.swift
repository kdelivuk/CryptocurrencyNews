//
//  SettingsVMProtocol.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 25/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import Defines
import RxSwift

enum SettingsVMItem {
    case limit
    case fiat
}

protocol SettingsVMProtocol {
    
    var title: String { get }
    var headerTitle: String { get }
    var footerTitle: String { get }
    
    var numberOfItems: Int { get }
    var currencies: [FiatCurrency] { get }
    
    var initialFiatCurrency: FiatCurrency { get }
    
    var limitResultsTitle: String { get }
    var fiatCurrencyTitle: String { get }
    
    var selectedCurrencyObservable: Observable<FiatCurrency> { get }
    var limitObservable: Observable<Int> { get }
    
    func item(for indexPath: IndexPath) -> SettingsVMItem
    
    func selectCurrency(at row: Int)
    func changeLimit(to limit: String)
}

extension SettingsVMItem {
    func configure() -> String {
        switch self {
        case .limit:
            return NSLocalizedString("Limit", comment: "SettingsVMItem.limit")
        case .fiat:
            return NSLocalizedString("Fiat currency", comment: "SettingsVMItem.fiat")
        }
    }
}
