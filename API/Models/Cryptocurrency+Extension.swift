//
//  Cryptocurrency+Extension.swift
//  API
//
//  Created by Kristijan Delivuk on 27/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import Defines

extension Cryptocurrency {
    
    init?(jsonDict: [String: Any], currency: FiatCurrency) {
        
        guard
            let id = jsonDict["id"] as? String,
            let name = jsonDict["name"] as? String,
            let symbol = jsonDict["symbol"] as? String,
            let rank = jsonDict["rank"] as? String,
            let priceInFiat = jsonDict["price_\(currency.rawValue)"] as? String,
            let priceInBtc = jsonDict["price_btc"] as? String,
            let h24_volume_fiat = jsonDict["24h_volume_\(currency.rawValue)"] as? String,
            let market_cap_fiat = jsonDict["market_cap_\(currency.rawValue)"] as? String,
            let availableSupply = jsonDict["available_supply"] as? String,
            let totalSupply = jsonDict["total_supply"] as? String,
            let changeIn1h = jsonDict["percent_change_1h"] as? String,
            let changeIn24h = jsonDict["percent_change_24h"] as? String,
            let changeIn7d = jsonDict["percent_change_7d"] as? String,
            let last_updated = jsonDict["last_updated"] as? String
            else {
                return nil
        }
        
        self.id = id
        self.name = name
        self.symbol = symbol
        self.rank = rank
        self.priceInFiat = priceInFiat
        self.priceInBtc = priceInBtc
        self.h24_volume_fiat = h24_volume_fiat
        self.market_cap_fiat = market_cap_fiat
        self.availableSupply = availableSupply
        self.totalSupply = totalSupply
        self.changeIn1h = Double(changeIn1h) ?? 0.0
        self.changeIn24h = Double(changeIn24h) ?? 0.0
        self.changeIn7d = Double(changeIn7d) ?? 0.0
        self.last_updated = last_updated
    }
}
