//
//  NewsVMMock.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 24/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import Foundation

final class NewsVMMock: NewsVMProtocol {
    
    // MARK: - Coordinator Actions
    
    var onDidTapItem: ((Currency) -> ()) = { _ in }
    
    // MARK: - Public Properties
    
    var numberOfRows: Int
    
    // MARK: - Private Properties
    
    private var items: [Currency]
    
    // MARK: - Class Lifecycle
    
    init() {
        items = CurrencyMock.generateData()
        numberOfRows = CurrencyMock.generateData().count
    }
    
    // MARK: - Public Methods
    
    func item(for indexPath: IndexPath) -> Currency {
        return items[indexPath.row]
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        onDidTapItem(items[indexPath.row])
    }
}

struct CurrencyMock {
    
    static private var currencies: [Currency] = [
        Currency(name: "bitcoin"),
        Currency(name: "bitcoin"),
        Currency(name: "bitcoin"),
        Currency(name: "bitcoin"),
        Currency(name: "bitcoin")
    ]
    
    static func generateData() -> [Currency] {
        return currencies
    }
}
