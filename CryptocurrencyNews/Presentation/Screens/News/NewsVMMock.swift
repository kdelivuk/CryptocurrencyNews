//
//  NewsVMMock.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 24/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import RxSwift

final class NewsVMMock: NewsVMProtocol {
    
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
        _state = Variable(NewsVMState.top100([]))
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
        if word.characters.count > 0 {
        
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
            _state.value = NewsVMState.top100(items)
        }
    }
}

struct CurrencyMock {
    
    static private var currencies: [Currency] = [
        Currency(name: "bitcoin"),
        Currency(name: "ethereum"),
        Currency(name: "ripple"),
        Currency(name: "bitcoin-cash"),
        Currency(name: "litecoin"),
        Currency(name: "dash"),
        Currency(name: "nem"),
        Currency(name: "neo"),
        Currency(name: "bitconnect"),
        Currency(name: "monero"),
        Currency(name: "iota"),
        Currency(name: "ethereum-classic"),
        Currency(name: "qtum"),
        Currency(name: "cardano"),
        Currency(name: "stellar"),
        Currency(name: "lisk"),
        Currency(name: "zcash")
    ]
    
    static func generateData() -> [Currency] {
        return currencies
    }
}
