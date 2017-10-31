//
//  SettingsVM.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 25/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import Foundation

final class SettingsVM: SettingsVMProtocol {
    
    let items: [SettingsVMItem]
    
    var numberOfItems: Int {
        return items.count
    }
    
    init() {
        items = [.limit, .fiat]
    }
    
    func item(for indexPath: IndexPath) -> SettingsVMItem {
        return items[indexPath.row]
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        
    }
}
