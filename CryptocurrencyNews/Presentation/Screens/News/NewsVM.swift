//
//  NewsVM.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 23/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import RxSwift

final class NewsVM: NewsVMProtocol {
    func search(word: String) {
        
    }
    
    
    var disposeBag: DisposeBag
    var stateObservable: Observable<NewsVMState>
    

    var numberOfRows: Int

    // MARK: - Class Lifecycle
    
    init() {
        disposeBag = DisposeBag()
        stateObservable = Observable.empty()
        numberOfRows = 0
    }
    
    func clear() {
        
    }
    func didSelectItem(at indexPath: IndexPath) {
    
    }
    
    func item(for indexPath: IndexPath) -> Currency {
        return Currency(name: "")
    }
}
