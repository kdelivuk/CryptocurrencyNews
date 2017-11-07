//
//  Cryptocurrency.swift
//  Defines
//
//  Created by Kristijan Delivuk on 07/11/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import Foundation

public struct Cryptocurrency {
    public let id: String
    public let name: String
    public let symbol: String
    public let rank: String
    public let priceInFiat: String
    public let priceInBtc: String
    public let h24_volume_fiat: String
    public let market_cap_fiat: String
    public let availableSupply: String
    public let totalSupply: String
    public let changeIn1h: Double
    public let changeIn24h: Double
    public let changeIn7d: Double
    public let last_updated: String
}
