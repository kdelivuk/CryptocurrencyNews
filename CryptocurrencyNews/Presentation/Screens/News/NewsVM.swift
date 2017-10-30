//
//  NewsVM.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 23/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import RxSwift

final class NewsVM: NewsVMProtocol {

    // MARK: - Public Properties

    var disposeBag: DisposeBag
    var stateObservable: Observable<NewsVMState>
    
    var numberOfRows: Int

    private let cryptocurrencyManager: CryptocurrencyManagerProtocol
    
    // MARK: - Class Lifecycle

    init(cryptocurrencyManager: CryptocurrencyManagerProtocol) {
        self.cryptocurrencyManager = cryptocurrencyManager
        disposeBag = DisposeBag()
        stateObservable = Observable.empty()
        numberOfRows = 0
    }
    
    func search(word: String) {
        cryptocurrencyManager.search()
    }
    
    func clear() {
        
    }
    func didSelectItem(at indexPath: IndexPath) {
    
    }
    
    func item(for indexPath: IndexPath) -> Currency {
        return Currency(rank: "1", name: "", priceInFiat: "", change: "")
    }
}
