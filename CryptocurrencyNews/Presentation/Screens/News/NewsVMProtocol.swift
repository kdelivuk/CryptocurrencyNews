//
//  NewsVMProtocol.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 23/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import RxSwift
import Defines

enum NewsVMState: RawRepresentable {
    
    typealias RawValue = String
    
    var rawValue: String {
        switch self {
        case .top(_):
            return "top"
        case .search(_):
            return "search"
        }
    }
    
    case top([Cryptocurrency])
    case search(SearchResultState)
    
    init?(rawValue: String) {
        switch rawValue {
        case "top":
            self = .top([])
        case "search":
            self = .search(SearchResultState.empty)
        default:
            return nil
        }
    }
}

enum SearchResultState {
    case empty
    case searching
    case results([Cryptocurrency])
    case error(Error)
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
    
    func item(for indexPath: IndexPath) -> Cryptocurrency
    func didSelectItem(at indexPath: IndexPath)
}
