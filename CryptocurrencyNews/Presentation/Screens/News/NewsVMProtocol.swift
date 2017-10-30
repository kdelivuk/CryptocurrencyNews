//
//  NewsVMProtocol.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 23/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import RxSwift

enum NewsVMState {
    case top100([Currency])
    case search(SearchResultState)
}

enum SearchResultState {
    case empty
    case searching
    case results([Currency])
    case error(Error)
}

struct Currency {
    let rank: String
    let name: String
    let priceInFiat: String
    let change: String
    
    init(rank: String, name: String, priceInFiat: String, change: String) {
        self.rank = rank
        self.name = name
        self.priceInFiat = priceInFiat
        self.change = change
    }
}


protocol NewsVMProtocol {
    var disposeBag: DisposeBag { get }
    var numberOfRows: Int { get }
    var stateObservable: Observable<NewsVMState> { get }
    
    func search(word: String)
    func clear()
    
    func item(for indexPath: IndexPath) -> Currency
    func didSelectItem(at indexPath: IndexPath)
}
