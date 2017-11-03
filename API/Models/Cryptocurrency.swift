//
//  Cryptocurrency.swift
//  API
//
//  Created by Kristijan Delivuk on 27/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import Defines

public struct Cryptocurrency {

    public let id: String
    public let name: String
    public let symbol: String
    public let rank: String
    public let price_usd: String
    public let price_btc: String
    public let h24_volume_usd: String
    public let market_cap_usd: String
    public let available_supply: String
    public let total_supply: String
    public let percent_change_1h: Double
    public let percent_change_24h: Double
    public let percent_change_7d: Double
    public let last_updated: String
    
    init?(jsonDict: [String: Any], currency: FiatCurrency) {
        
        guard
            let id = jsonDict["id"] as? String,
            let name = jsonDict["name"] as? String,
            let symbol = jsonDict["symbol"] as? String,
            let rank = jsonDict["rank"] as? String,
            let price_usd = jsonDict["price_\(currency.rawValue)"] as? String,
            let price_btc = jsonDict["price_btc"] as? String,
            let h24_volume_usd = jsonDict["24h_volume_\(currency.rawValue)"] as? String,
            let market_cap_usd = jsonDict["market_cap_\(currency.rawValue)"] as? String,
            let available_supply = jsonDict["available_supply"] as? String,
            let total_supply = jsonDict["total_supply"] as? String,
            let percent_change_1h = jsonDict["percent_change_1h"] as? String,
            let percent_change_24h = jsonDict["percent_change_24h"] as? String,
            let percent_change_7d = jsonDict["percent_change_7d"] as? String,
            let last_updated = jsonDict["last_updated"] as? String
            else {
                return nil
        }
        
        self.id = id
        self.name = name
        self.symbol = symbol
        self.rank = rank
        self.price_usd = price_usd
        self.price_btc = price_btc
        self.h24_volume_usd = h24_volume_usd
        self.market_cap_usd = market_cap_usd
        self.available_supply = available_supply
        self.total_supply = total_supply
        self.percent_change_1h = Double(percent_change_1h) ?? 0.0
        self.percent_change_24h = Double(percent_change_24h) ?? 0.0
        self.percent_change_7d = Double(percent_change_7d) ?? 0.0
        self.last_updated = last_updated
    }
}
