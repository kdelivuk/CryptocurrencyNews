//
//  NewsVMProtocol.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 23/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import RxSwift

enum NewsVMState {
    case top([Currency])
    case search(SearchResultState)
}

enum SearchResultState {
    case empty
    case searching
    case results([Currency])
    case error(Error)
}

struct Currency {
    let id: String
    let rank: String
    let name: String
    let symbol: String
    let priceInFiat: String
    let priceInBitcoin: String
    let changeIn1h: Double
    let changeIn24h: Double
    let changeIn7d: Double
    let availableSupply: String
    let totalSupply: String
    
    init(id: String, rank: String, name: String, symbol: String, priceInFiat: String, priceInBitcoin: String, changeIn1h: Double, changeIn24h: Double, changeIn7d: Double, availableSupply: String, totalSupply: String) {
        self.id = id
        self.rank = rank
        self.name = name
        self.symbol = symbol
        self.priceInFiat = priceInFiat
        self.priceInBitcoin = priceInBitcoin
        self.changeIn1h = changeIn1h
        self.changeIn24h = changeIn24h
        self.changeIn7d = changeIn7d
        self.availableSupply = availableSupply
        self.totalSupply = totalSupply
    }
}


protocol NewsVMProtocol {
    var disposeBag: DisposeBag { get }
    var numberOfRows: Int { get }
    var stateObservable: Observable<NewsVMState> { get }
    var titleObservable: Observable<String> { get }
    
    var priceInFiat: String { get }
    
    func search(word: String)
    func top()
    func clear()
    
    func item(for indexPath: IndexPath) -> Currency
    func didSelectItem(at indexPath: IndexPath)
}
