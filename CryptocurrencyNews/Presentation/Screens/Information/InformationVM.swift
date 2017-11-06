//
//  InformationVM.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 23/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import RxSwift
import Defines

enum InformationVMState {
    case loading
    case finished
    case error
}

final class InformationVM: InformationVMProtocol {
    
    let disposeBag: DisposeBag
    
    let _state: Variable<InformationVMState>
    lazy var stateObservable: Observable<InformationVMState> = self._state.asObservable().throttle(0.5, scheduler: MainScheduler.instance)
    
    private var currency: Currency
    private let cryptocurrencyManager: CryptocurrencyManagerProtocol
    
    private var concurrencyInformation: [ConcurrencyInformation]
    
    var title: String {
        return currency.name
    }
    
    var numberOfItems: Int {
        return concurrencyInformation.count
    }
    
    init(currency: Currency, cryptocurrencyManager: CryptocurrencyManagerProtocol) {
        self.disposeBag = DisposeBag()
        self.currency = currency
        self._state = Variable(InformationVMState.finished)
        self.cryptocurrencyManager = cryptocurrencyManager
        self.concurrencyInformation = [.rank, .name, .symbol, .priceInFiat(cryptocurrencyManager.fiatCurrency), .priceInBitcoin, .changeIn1h, .changeIn24h, .changeIn7d, .availableSupply, .totalSupply]
        
        self.cryptocurrencyManager
            .fiatCurrencyObservable
            .subscribe(onNext: { [weak self] currency in
                guard let weakself = self else { return }
                weakself.refresh()
            }).disposed(by: disposeBag)
    }
    
    func title(for indexPath: IndexPath) -> String {
        return concurrencyInformation[indexPath.row].title()
    }
    
    func value(for indexPath: IndexPath) -> String {
        return concurrencyInformation[indexPath.row].value(for: currency)
    }
    
    func refresh() {
        _state.value = .loading
        cryptocurrencyManager
            .currency(for: currency.id)
            .subscribe({ (currency) in
                switch currency {
                case .next(let currency):
                    self.concurrencyInformation = [.rank, .name, .symbol, .priceInFiat(self.cryptocurrencyManager.fiatCurrency), .priceInBitcoin, .changeIn1h, .changeIn24h, .changeIn1h, .availableSupply, .totalSupply]
                    self.currency = Currency(id: currency.id, rank: currency.rank, name: currency.name, symbol: currency.symbol, priceInFiat: currency.price_fiat, priceInBitcoin: currency.price_btc, changeIn1h: currency.percent_change_1h, changeIn24h: currency.percent_change_24h, changeIn7d: currency.percent_change_7d, availableSupply: currency.available_supply, totalSupply: currency.total_supply)
                case .error(_):
                    self._state.value = .error
                case .completed:
                    self._state.value = .finished
                }
            }).disposed(by: disposeBag)
    }
    
    deinit {
        print("\(self) DEINIT")
    }
}

extension ConcurrencyInformation {
    func title() -> String {
        switch self {
        case .rank:
            return NSLocalizedString("Rank", comment: "ConcurrencyInformation.rank")
        case .name:
            return NSLocalizedString("Name", comment: "ConcurrencyInformation.name")
        case .symbol:
            return NSLocalizedString("Symbol", comment: "ConcurrencyInformation.symbol")
        case .priceInFiat(let fiatCurrency):
            return NSLocalizedString("Price in \(fiatCurrency.title())", comment: "ConcurrencyInformation.symbol")
        case .priceInBitcoin:
            return NSLocalizedString("Price in Bitcoin", comment: "ConcurrencyInformation.priceInBitcion")
        case .changeIn1h:
            return NSLocalizedString("Change in 1 hour", comment: "ConcurrencyInformation.changeIn1h")
        case .changeIn7d:
            return NSLocalizedString("Change in 7 days", comment: "ConcurrencyInformation.changeIn7d")
        case .changeIn24h:
            return NSLocalizedString("Change in 24 hours", comment: "ConcurrencyInformation.changeIn24h")
        case .availableSupply:
            return NSLocalizedString("Available supply", comment: "ConcurrencyInformation.availableSupply")
        case .totalSupply:
            return NSLocalizedString("Total supply", comment: "ConcurrencyInformation.totalSupply")
        }
    }
}

extension ConcurrencyInformation {
    func value(for currency: Currency) -> String {
        switch self {
        case .rank:
            return currency.rank
        case .name:
            return currency.name
        case .symbol:
            return currency.symbol
        case .priceInFiat:
            return currency.priceInFiat
        case .priceInBitcoin:
            return currency.priceInBitcoin
        case .changeIn1h:
            return "\(currency.changeIn1h*100)%"
        case .changeIn7d:
            return "\(currency.changeIn7d*100)%"
        case .changeIn24h:
            return "\(currency.changeIn24h*100)%"
        case .availableSupply:
            return currency.availableSupply
        case .totalSupply:
            return currency.totalSupply
        }
    }
}
