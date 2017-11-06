//
//  NewsVM.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 23/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import RxSwift

final class NewsVM: NewsVMProtocol {
    
    // MARK: - Coordinator Actions
    
    var onDidTapItem: ((Currency) -> ()) = { _ in }
    
    // MARK: - Public Properties
    
    lazy var stateObservable: Observable<NewsVMState> = self._state.asObservable().throttle(0.5, scheduler: MainScheduler.instance)
    
    let disposeBag: DisposeBag
    
    var numberOfRows: Int {
        return filteredCriptocurrencies.count
    }
    
    var priceInFiat: String
    
    lazy var titleObservable: Observable<String> = self._title.asObservable().throttle(0.5, scheduler: MainScheduler.instance)
    private var _title: Variable<String>
    
    // MARK: - Private Properties
    
    private var criptocurrencies: [Currency]
    private var filteredCriptocurrencies: [Currency]
    private let _state: Variable<NewsVMState>
    
    private let cryptocurrencyManager: CryptocurrencyManagerProtocol
    
    // MARK: - Class Lifecycle
    
    init(cryptocurrencyManager: CryptocurrencyManagerProtocol) {
        self.cryptocurrencyManager = cryptocurrencyManager
        disposeBag = DisposeBag()
        _state = Variable(NewsVMState.top([]))
        criptocurrencies = []
        filteredCriptocurrencies = []
        _title = Variable(NSLocalizedString("Top \(cryptocurrencyManager.limit)", comment: ""))
        priceInFiat = "Prince in \(cryptocurrencyManager.fiatCurrency)"
        
        cryptocurrencyManager
            .limitObservable
            .subscribe(onNext: { [weak self] limit in
                guard let weakself = self else { return }
                
                switch weakself._state.value {
                case .top:
                    weakself._title.value = NSLocalizedString("Top \(limit)", comment: "")
                case .search(let state):
                    switch state {
                    case .searching:
                        weakself._title.value = NSLocalizedString("Searching...", comment: "")
                    default:
                        weakself._title.value = ""
                    }
                }
                
                weakself.top()
                
            }).disposed(by: disposeBag)
        
        cryptocurrencyManager
            .fiatCurrencyObservable
            .subscribe(onNext: { [weak self] currency in
                guard let weakself = self else { return }
                weakself.priceInFiat = NSLocalizedString("Prince in \(currency.title())", comment: "")
                weakself.top()
            }).disposed(by: disposeBag)
    }
    
    func search(word: String) {
        // set state to searching which enables spinner
        // while quering for result
        _state.value = .search(.searching)
        
        // if there are more than 0 characters currently
        // present in the searchbar
        if word.count > 0 {
            
            clear()
            
            // query through all the items and find ones that contain search word
            filteredCriptocurrencies = self.criptocurrencies.filter({$0.name.contains(word)})
            
            // if there are no items that satisfy our search result
            // set the empty state for search table view
            if filteredCriptocurrencies.count == 0 {
                self._state.value = NewsVMState.search(SearchResultState.empty)
            } else {
                // else return those items and show them to user
                self._state.value = NewsVMState.search(SearchResultState.results(self.filteredCriptocurrencies))
            }
            
            self._title.value = NSLocalizedString("\(word)", comment: "")
            
        } else {
            // if the search bar is empty
            // show the top results to the user
            top()
        }
    }
    
    func top() {
        cryptocurrencyManager
            .top()
            .subscribe(onNext: { [weak self] currencies in
                guard let weakself = self else { return }
                weakself.criptocurrencies = currencies.map { Currency(id: $0.id, rank: $0.rank, name: $0.name, symbol: $0.symbol, priceInFiat: $0.price_fiat, priceInBitcoin: $0.price_btc, changeIn1h: $0.percent_change_1h, changeIn24h: $0.percent_change_24h, changeIn7d: $0.percent_change_7d, availableSupply: $0.available_supply, totalSupply: $0.total_supply) }
                weakself.filteredCriptocurrencies = weakself.criptocurrencies
                weakself._title.value = NSLocalizedString("Top \(weakself.cryptocurrencyManager.limit)", comment: "")
                weakself._state.value = NewsVMState.top(weakself.filteredCriptocurrencies)
            }).disposed(by: disposeBag)
    }
    
    func clear() {
        filteredCriptocurrencies = []
    }
    
    // MARK: - Public Methods
    
    func item(for indexPath: IndexPath) -> Currency {
        return filteredCriptocurrencies[indexPath.row]
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        onDidTapItem(filteredCriptocurrencies[indexPath.row])
    }
}
