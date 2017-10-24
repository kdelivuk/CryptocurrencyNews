//
//  NewsVM.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 23/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import Foundation

final class NewsVM: NewsVMProtocol {

    var numberOfRows: Int

    // MARK: - Class Lifecycle
    
    init() {
        numberOfRows = 0
    }
    
    func didSelectItem(at indexPath: IndexPath) {
    
    }
    
    func item(for indexPath: IndexPath) -> Currency {
        return Currency(name: "")
    }
}
