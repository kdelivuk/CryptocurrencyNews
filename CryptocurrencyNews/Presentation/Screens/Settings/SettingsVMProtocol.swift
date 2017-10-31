//
//  SettingsVMProtocol.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 25/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import Foundation

enum SettingsVMItem {
    case limit
    case fiat
}

protocol SettingsVMProtocol {
    var numberOfItems: Int { get }
    
    func item(for indexPath: IndexPath) -> SettingsVMItem
    func didSelectItem(at indexPath: IndexPath)
}

extension SettingsVMItem {
    func configure() -> String {
        switch self {
        case .limit:
            return NSLocalizedString("Limit", comment: "SettingsVMItem.limit")
        case .fiat:
            return NSLocalizedString("Fiat currency", comment: "SettingsVMItem.fiat")
        }
    }
}
