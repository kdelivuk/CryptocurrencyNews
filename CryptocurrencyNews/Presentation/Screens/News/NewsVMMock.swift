//
//  NewsVMMock.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 24/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import RxSwift

final class NewsVMMock: NewsVMProtocol {
    
    var titleObservable = Observable<String>.empty()
    
    var priceInFiat: String  = "Price in fiat"
    
    var title: String = "Top 100"
    
    let disposeBag: DisposeBag
    
    // MARK: - Coordinator Actions
    
    var onDidTapItem: ((Currency) -> ()) = { _ in }
    
    // MARK: - Public Properties
    
    var numberOfRows: Int {
        return items.count
    }
    
    lazy var stateObservable: Observable<NewsVMState> = self._state.asObservable().throttle(0.5, scheduler: MainScheduler.instance)
    
    // MARK: - Private Properties
    
    private var items: [Currency]
    private let _state: Variable<NewsVMState>
    
    // MARK: - Class Lifecycle
    
    init() {
        _state = Variable(NewsVMState.top([]))
        items = CurrencyMock.generateData()
        disposeBag = DisposeBag()
    }
    
    // MARK: - Public Methods
    
    func item(for indexPath: IndexPath) -> Currency {
        return items[indexPath.row]
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        onDidTapItem(items[indexPath.row])
    }
    
    
    func clear() {
        items = []
    }
    
    func search(word: String) {
        // set state to searching which enables spinner
        // while quering for result
        _state.value = .search(.searching)
        
        // if there are more than 0 characters currently
        // present in the searchbar
        if word.count > 0 {
        
            // query through all the mock items and find ones that contain search word
            items = CurrencyMock.generateData().filter({$0.name.lowercased().contains(word.lowercased())})
            
            // if there are no items that satisfy our search result
            // set the empty state for search table view
            if items.count == 0 {
                items = []
                _state.value = NewsVMState.search(SearchResultState.empty)
            } else {
                // else return those items and show them to user
                _state.value = NewsVMState.search(SearchResultState.results(items))
            }
        } else {
            // if the search bar is empty
            // show the top 100 results to the user
            items = CurrencyMock.generateData()
            _state.value = NewsVMState.top(items)
        }
    }
    
    func top() {
        
    }
}

struct CurrencyMock {
    
    static private var currencies: [Currency] = [
//        Currency(rank: "1", name: "bitcoin", priceInFiat: "5738.89", changeIn24h: 3113190000.0),
//        Currency(rank: "2", name: "ethereum", priceInFiat: "5738.89", changeIn24h: 3113190000.0),
//        Currency(rank: "3", name: "ripple", priceInFiat: "5738.89", changeIn24h: 3113190000.0),
//        Currency(rank: "4", name: "bitcoin-cash", priceInFiat: "5738.89", changeIn24h: 3113190000.0),
//        Currency(rank: "5", name: "litecoin", priceInFiat: "5738.89", changeIn24h: 3113190000.0),
//        Currency(rank: "6", name: "dash", priceInFiat: "5738.89", changeIn24h: 3113190000.0),
//        Currency(rank: "7", name: "neo", priceInFiat: "5738.89", changeIn24h: 3113190000.0),
//        Currency(rank: "8", name: "bitconnect", priceInFiat: "5738.89", changeIn24h: 3113190000.0),
//        Currency(rank: "9", name: "monero", priceInFiat: "5738.89", changeIn24h: 3113190000.0),
//        Currency(rank: "10", name: "iota", priceInFiat: "5738.89", changeIn24h: 3113190000.0),
//        Currency(rank: "11", name: "ethereum-classic", priceInFiat: "5738.89", changeIn24h: 3113190000.0),
//        Currency(rank: "12", name: "qtum", priceInFiat: "5738.89", changeIn24h: 3113190000.0),
//        Currency(rank: "13", name: "cardano", priceInFiat: "5738.89", changeIn24h: 3113190000.0),
//        Currency(rank: "14", name: "stellar", priceInFiat: "5738.89", changeIn24h: 3113190000.0),
//        Currency(rank: "15", name: "lisk", priceInFiat: "5738.89", changeIn24h: 3113190000.0),
//        Currency(rank: "16", name: "zcash", priceInFiat: "5738.89", changeIn24h: 3113190000.0)
    ]
    
    static func generateData() -> [Currency] {
        return currencies
    }
}
