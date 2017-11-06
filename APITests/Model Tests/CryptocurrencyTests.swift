//
//  CryptocurrencyTests.swift
//  APITests
//
//  Created by Kristijan Delivuk on 06/11/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import XCTest
@testable import Defines
@testable import API

class CryptocurrencyModelTests: XCTestCase {
    
    // Test case
    // ---
    // Testing the successful parsing of concurrency object
    // for USD fiat valut
    func testSuccessfulParsingOfCryptocurrencyObjectForUSDFiat() {
        
        let data = cryptocurrencyUSDDummyObjectResponse.data(using: .utf8)!
        let jsonDict = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as! [String : Any]
        let cryptocurrency = Cryptocurrency(jsonDict: jsonDict, currency: .usd)
        
        if let cryptocurrency = cryptocurrency {
            XCTAssert(cryptocurrency.id == "bitcoin", "Cryptocurrency id must be bitcoin")
            XCTAssert(cryptocurrency.name == "Bitcoin", "Cryptocurrency name must be bitcoin")
            XCTAssert(cryptocurrency.symbol == "BTC", "Cryptocurrency symbol must be BTC")
            XCTAssert(cryptocurrency.rank == "1", "Cryptocurrency rank must be 1")
            XCTAssert(cryptocurrency.price_fiat == "573.137", "Cryptocurrency price_fiat must be 573.137")
            XCTAssert(cryptocurrency.price_btc == "1.0", "Cryptocurrency price_btc must be 1.0")
            XCTAssert(cryptocurrency.h24_volume_fiat == "72855700.0", "Cryptocurrency price_fiat must be 72855700.0")
            XCTAssert(cryptocurrency.market_cap_fiat == "9080883500.0", "Cryptocurrency price_btc must be 9080883500.0")
            XCTAssert(cryptocurrency.available_supply == "15844176.0", "Cryptocurrency price_fiat must be 15844176.0")
            XCTAssert(cryptocurrency.total_supply == "15844176.0", "Cryptocurrency price_btc must be 15844176.0")
            XCTAssert(cryptocurrency.percent_change_1h == 0.04, "Cryptocurrency percent_change_1h must be 0.04")
            XCTAssert(cryptocurrency.percent_change_24h == -0.3, "Cryptocurrency percent_change_24h must be -0.3")
            XCTAssert(cryptocurrency.percent_change_7d == -0.57, "Cryptocurrency percent_change_7d must be -0.57")
        } else {
            XCTAssertFalse(false, "Parsing of cryptocurrency must not fail.")
        }
    }
    
    // Test case
    // ---
    // Testing the successful parsing of concurrency object
    // for EUR fiat valut
    func testSuccessfulParsingOfCryptoCurrencyObjectForEURFiat() {
        
        let data = cryptocurrencyEURDummyObjectResponse.data(using: .utf8)!
        let jsonDict = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as! [String : Any]
        let cryptocurrency = Cryptocurrency(jsonDict: jsonDict, currency: .eur)
        
        if let cryptocurrency = cryptocurrency {
            XCTAssert(cryptocurrency.id == "bitcoin", "Cryptocurrency id must be bitcoin")
            XCTAssert(cryptocurrency.name == "Bitcoin", "Cryptocurrency name must be bitcoin")
            XCTAssert(cryptocurrency.symbol == "BTC", "Cryptocurrency symbol must be BTC")
            XCTAssert(cryptocurrency.rank == "1", "Cryptocurrency rank must be 1")
            XCTAssert(cryptocurrency.price_fiat == "6183.05666265", "Cryptocurrency price_fiat must be 6183.05666265")
            XCTAssert(cryptocurrency.price_btc == "1.0", "Cryptocurrency price_btc must be 1.0")
            XCTAssert(cryptocurrency.h24_volume_fiat == "2774613085.65", "Cryptocurrency h24_volume_fiat must be 2774613085.65")
            XCTAssert(cryptocurrency.market_cap_fiat == "103054007052", "Cryptocurrency price_btc must be 103054007052")
            XCTAssert(cryptocurrency.available_supply == "16667162.0", "Cryptocurrency price_fiat must be 16667162.0")
            XCTAssert(cryptocurrency.total_supply == "16667162.0", "Cryptocurrency price_btc must be 16667162.0")
            XCTAssert(cryptocurrency.percent_change_1h == 2.2, "Cryptocurrency percent_change_1h must be 2.2")
            XCTAssert(cryptocurrency.percent_change_24h == -4.69, "Cryptocurrency percent_change_24h must be -4.69")
            XCTAssert(cryptocurrency.percent_change_7d == 17.51, "Cryptocurrency percent_change_7d must be 17.51")
        } else {
            XCTAssertFalse(false, "Parsing of cryptocurrency must not fail.")
        }
    }
    
    // Test case
    // ---
    // Testing the successful parsing of concurrency object
    // for CNY fiat valut
    func testSuccessfulParsingOfCryptoCurrencyObjectForCNYFiat() {
        let data = cryptocurrencyCNYDummyObjectResponse.data(using: .utf8)!
        let jsonDict = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as! [String : Any]
        let cryptocurrency = Cryptocurrency(jsonDict: jsonDict, currency: .cny)
        
        if let cryptocurrency = cryptocurrency {
            XCTAssert(cryptocurrency.id == "bitcoin", "Cryptocurrency id must be bitcoin")
            XCTAssert(cryptocurrency.name == "Bitcoin", "Cryptocurrency name must be bitcoin")
            XCTAssert(cryptocurrency.symbol == "BTC", "Cryptocurrency symbol must be BTC")
            XCTAssert(cryptocurrency.rank == "1", "Cryptocurrency rank must be 1")
            XCTAssert(cryptocurrency.price_fiat == "47570.856116", "Cryptocurrency price_fiat must be 47570.856116")
            XCTAssert(cryptocurrency.price_btc == "1.0", "Cryptocurrency price_btc must be 1.0")
            XCTAssert(cryptocurrency.h24_volume_fiat == "21347163236.0", "Cryptocurrency h24_volume_fiat must be 21347163236.0")
            XCTAssert(cryptocurrency.market_cap_fiat == "792871165364", "Cryptocurrency price_btc must be 792871165364")
            XCTAssert(cryptocurrency.available_supply == "16667162.0", "Cryptocurrency price_fiat must be 16667162.0")
            XCTAssert(cryptocurrency.total_supply == "16667162.0", "Cryptocurrency price_btc must be 16667162.0")
            XCTAssert(cryptocurrency.percent_change_1h == 2.2, "Cryptocurrency percent_change_1h must be 2.2")
            XCTAssert(cryptocurrency.percent_change_24h == -4.69, "Cryptocurrency percent_change_24h must be -4.69")
            XCTAssert(cryptocurrency.percent_change_7d == 17.51, "Cryptocurrency percent_change_7d must be 17.51")
        } else {
            XCTAssertFalse(false, "Parsing of cryptocurrency must not fail.")
        }
    }
}

fileprivate let cryptocurrencyUSDDummyObjectResponse: String = """
{
    "id": "bitcoin",
    "name": "Bitcoin",
    "symbol": "BTC",
    "rank": "1",
    "price_usd": "573.137",
    "price_btc": "1.0",
    "24h_volume_usd": "72855700.0",
    "market_cap_usd": "9080883500.0",
    "available_supply": "15844176.0",
    "total_supply": "15844176.0",
    "percent_change_1h": "0.04",
    "percent_change_24h": "-0.3",
    "percent_change_7d": "-0.57",
    "last_updated": "1472762067"
}
"""
    
fileprivate let cryptocurrencyCNYDummyObjectResponse: String = """
{
    "id": "bitcoin",
    "name": "Bitcoin",
    "symbol": "BTC",
    "rank": "1",
    "price_usd": "7171.63",
    "price_btc": "1.0",
    "24h_volume_usd": "3218230000.0",
    "market_cap_usd": "119530719014",
    "available_supply": "16667162.0",
    "total_supply": "16667162.0",
    "max_supply": "21000000.0",
    "percent_change_1h": "2.2",
    "percent_change_24h": "-4.69",
    "percent_change_7d": "17.51",
    "last_updated": "1510000152",
    "price_cny": "47570.856116",
    "24h_volume_cny": "21347163236.0",
    "market_cap_cny": "792871165364"
}
"""

fileprivate let cryptocurrencyEURDummyObjectResponse: String = """
{
    "id": "bitcoin",
    "name": "Bitcoin",
    "symbol": "BTC",
    "rank": "1",
    "price_usd": "7171.63",
    "price_btc": "1.0",
    "24h_volume_usd": "3218230000.0",
    "market_cap_usd": "119530719014",
    "available_supply": "16667162.0",
    "total_supply": "16667162.0",
    "max_supply": "21000000.0",
    "percent_change_1h": "2.2",
    "percent_change_24h": "-4.69",
    "percent_change_7d": "17.51",
    "last_updated": "1510000152",
    "price_eur": "6183.05666265",
    "24h_volume_eur": "2774613085.65",
    "market_cap_eur": "103054007052"
}
"""
