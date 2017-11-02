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
        return criptocurrencies.count
    }
    
    var title: String {
        switch _state.value {
        case .top:
            return NSLocalizedString("Top \(cryptocurrencyManager.limit)", comment: "")
        case .search(let state):
            switch state {
            case .searching:
                return NSLocalizedString("Searching...", comment: "")
            default:
                return ""
            }
        }
    }
    // MARK: - Private Properties
    
    private var criptocurrencies: [Currency]
    private let _state: Variable<NewsVMState>
    
    
    private let cryptocurrencyManager: CryptocurrencyManagerProtocol
    
    // MARK: - Class Lifecycle
    
    init(cryptocurrencyManager: CryptocurrencyManagerProtocol) {
        self.cryptocurrencyManager = cryptocurrencyManager
        disposeBag = DisposeBag()
        _state = Variable(NewsVMState.top([]))
        criptocurrencies = []
    }
    
    func search(word: String) {
        // set state to searching which enables spinner
        // while quering for result
        _state.value = .search(.searching)
        
        // if there are more than 0 characters currently
        // present in the searchbar
        if word.characters.count > 0 {
            
            // query through all the mock items and find ones that contain search word
//            cryptocurrencyManager
//                .search()
//                .throttle(0.5, scheduler: MainScheduler.instance)
//                .subscribe(onNext: { (currencies) in
//                    // if there are no items that satisfy our search result
//                    // set the empty state for search table view
//                    if currencies.count == 0 {
//                        self.criptocurrencies = []
//                        self._state.value = NewsVMState.search(SearchResultState.empty)
//                    } else {
//                        // else return those items and show them to user
//                        self.criptocurrencies = currencies.map { Currency(rank: $0.rank, name: $0.symbol, priceInFiat: $0.price_usd, change: $0.percent_change_24h) }
//                        self._state.value = NewsVMState.search(SearchResultState.results(self.criptocurrencies))
//                    }
//                }, onError: { (error) in
//
//                }, onCompleted: {
//
//                }).disposed(by: disposeBag)
            
            
        } else {
            // if the search bar is empty
            // show the top 100 results to the user
            cryptocurrencyManager
                .search()
                .subscribe(onNext: { (currencies) in
                    self.criptocurrencies = currencies.map { Currency(rank: $0.rank, name: $0.symbol, priceInFiat: $0.price_usd, changeIn24h: $0.percent_change_24h) }
                    self._state.value = NewsVMState.top(self.criptocurrencies)
                }).disposed(by: disposeBag)
        }
    }
    
    
    func clear() {
        criptocurrencies = []
    }
    
    // MARK: - Public Methods
    
    func item(for indexPath: IndexPath) -> Currency {
        return criptocurrencies[indexPath.row]
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        onDidTapItem(criptocurrencies[indexPath.row])
    }
}
