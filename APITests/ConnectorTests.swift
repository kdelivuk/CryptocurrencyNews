//
//  ConnectorTests.swift
//  APITests
//
//  Created by Kristijan Delivuk on 06/11/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import XCTest
import RxBlocking
@testable import Defines
@testable import API

class ConnectorTests: XCTestCase {
    
    // Test case
    // ---
    // Testing the successful receiving of cryptocurrency objects from server
    // Results are limited to 100
    func testSuccessfullyRetrievingTheDataFromCriptoccurenciesEndpoint() {
        let connector = Connector()
        let request = try! connector.getCryptocurrencies(limit: 100, in: FiatCurrency.usd).toBlocking(timeout: 10).first()!
        switch request {
        case .success(let result):
            XCTAssert(result.count == 100, "Number of results must be 100")
        case .error:
            XCTAssertFalse(false)
        }
    }
    
    // Test case
    // ---
    // Testing the successful receiving of "bitcoin" object from server
    // in EUR fiat currency
    func testSuccessfullyRetrievingTheDataForBitcoinFromCriptoccurenciesEndpoint() {
        let connector = Connector()
        let request = try! connector.getCryptocurrency(for: "bitcoin", in: FiatCurrency.eur).toBlocking(timeout: 10).first()!
        switch request {
        case .success(let result):
            XCTAssert(true)
        case .error:
            XCTAssertFalse(false)
        }
    }
}
