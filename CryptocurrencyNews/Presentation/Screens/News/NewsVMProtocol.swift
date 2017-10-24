//
//  NewsVMProtocol.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 23/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import Foundation

struct Currency {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}


protocol NewsVMProtocol {
    var numberOfRows: Int { get }
    
    func item(for indexPath: IndexPath) -> Currency
    func didSelectItem(at indexPath: IndexPath)
}
