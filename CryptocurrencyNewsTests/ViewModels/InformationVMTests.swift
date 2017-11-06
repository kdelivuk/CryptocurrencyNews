//
//  InformationVMTests.swift
//  CryptocurrencyNewsTests
//
//  Created by Kristijan Delivuk on 06/11/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking

@testable import CryptocurrencyNews

class InformationVMTests: XCTestCase {
    
    // Private method used for injecting VM
    // into other test methods
    private func prepareVM(block: (InformationVM) -> ()) {
        let cryptocurrencyManagerMock = CryptocurrencyManagerMock()
        let currencyBitcoin = Currency(id: "bitcoin", rank: "1", name: "Bitcoin", symbol: "BTC", priceInFiat: "7155.55", priceInBitcoin: "1.0", changeIn1h: 0.87, changeIn24h: -4.62, changeIn7d: 17.18, availableSupply: "16667200.0", totalSupply: "16667200.0")
        let informationVM = InformationVM(currency: currencyBitcoin, cryptocurrencyManager: cryptocurrencyManagerMock)
        
        block(informationVM)
    }
    
    // Test case
    // ---------
    // Initial state must be equal to Top 100
    func testNumberOfItemsIsEqualTo10() {
        prepareVM { (informationVM) in
            let numberOfItems = informationVM.numberOfItems
            
            XCTAssert(numberOfItems == 10, "Number of items must be equal to 10.")
        }
    }
    
    // Test case
    // ---------
    // Initial title must be equal to "Bitcoin"
    func testTitleIsEqualToBitcoin() {
        prepareVM { (informationVM) in
            let title = informationVM.title
            
            XCTAssert(title == "Bitcoin", "Title must be equal to Bitcoin")
        }
    }
    
    // Test case
    // ---------
    // Initial state must be equal to "finished"
    func testInitialStateMustBeEqualToFinised() {
        prepareVM { (informationVM) in
            let state = try! informationVM.stateObservable.toBlocking(timeout: 10.0).first()!
            XCTAssert(state == .finished, "State must be equal to \"finished\"")
        }
    }
    
    // Test case
    // ---------
    // Test all title names for all defined fields
    func testTitleNamesForIndexes() {
        prepareVM { (informationVM) in
            let rankTitle = informationVM.title(for: IndexPath(item: 0, section: 0))
            let nameTitle = informationVM.title(for: IndexPath(item: 1, section: 0))
            let symbolTitle = informationVM.title(for: IndexPath(item: 2, section: 0))
            let priceInFiatTitle = informationVM.title(for: IndexPath(item: 3, section: 0))
            let priceInBitcoinTitle = informationVM.title(for: IndexPath(item: 4, section: 0))
            let changeIn1hTitle = informationVM.title(for: IndexPath(item: 5, section: 0))
            let changeIn24hTitle = informationVM.title(for: IndexPath(item: 6, section: 0))
            let changeIn7dTitle = informationVM.title(for: IndexPath(item: 7, section: 0))
            let availableSupplyTitle = informationVM.title(for: IndexPath(item: 8, section: 0))
            let totalSupplyTitle = informationVM.title(for: IndexPath(item: 9, section: 0))
            
            XCTAssert(rankTitle == "Rank", "Rank title must be \"Rank\"")
            XCTAssert(nameTitle == "Name", "Name title must be \"Name\"")
            XCTAssert(symbolTitle == "Symbol", "Symbol title must be \"Symbol\"")
            XCTAssert(priceInFiatTitle == "Price in USD", "Price in fiat title must be \"Price in USD\"")
            XCTAssert(priceInBitcoinTitle == "Price in Bitcoin", "Price in Bitcoin title must be \"Price in Bitcoin\"")
            XCTAssert(changeIn1hTitle == "Change in 1 hour", "Change in 1 hour title must be \"Change in 1 hour\"")
            XCTAssert(changeIn7dTitle == "Change in 7 days", "Change in 7 days title must be \"Change in 7 days\"")
            XCTAssert(changeIn24hTitle == "Change in 24 hours", "Change in 24 hours title must be \"Change in 24 hours\"")
            XCTAssert(availableSupplyTitle == "Available supply", "Available supply title must be \"Available supply\"")
            XCTAssert(totalSupplyTitle == "Total supply", "Total supply title must be \"Total supply\"")
        }
    }
    
    // Test case
    // ---------
    // Test all value results for all defined fields
    func testValuesForAllIndexes() {
        prepareVM { (informationVM) in
            let rankValue = informationVM.value(for: IndexPath(item: 0, section: 0))
            let nameValue = informationVM.value(for: IndexPath(item: 1, section: 0))
            let symbolValue = informationVM.value(for: IndexPath(item: 2, section: 0))
            let priceInFiatValue = informationVM.value(for: IndexPath(item: 3, section: 0))
            let priceInBitcoinValue = informationVM.value(for: IndexPath(item: 4, section: 0))
            let changeIn1hValue = informationVM.value(for: IndexPath(item: 5, section: 0))
            let changeIn7dValue = informationVM.value(for: IndexPath(item: 6, section: 0))
            let changeIn24hValue = informationVM.value(for: IndexPath(item: 7, section: 0))
            let availableSupplyValue = informationVM.value(for: IndexPath(item: 8, section: 0))
            let totalSupplyValue = informationVM.value(for: IndexPath(item: 9, section: 0))
            
            XCTAssert(rankValue == "1", "Rank value must be \"1\"")
            XCTAssert(nameValue == "Bitcoin", "Name value must be \"Bitcoin\"")
            XCTAssert(symbolValue == "BTC", "Symbol value must be \"BTC\"")
            XCTAssert(priceInFiatValue == "7155.55", "Price in fiat title must be \"7155.55\"")
            XCTAssert(priceInBitcoinValue == "1.0", "Price in Bitcoin value must be \"1.0\"")
            XCTAssert(changeIn1hValue == "87.0%", "Change in 1 hour value must be \"87.0%\"")
            XCTAssert(changeIn7dValue == "-462.0%", "Change in 7 days value must be \"-462.0\"")
            XCTAssert(changeIn24hValue == "1718.0%", "Change in 24 hours title must be \"1718.0%\"")
            XCTAssert(availableSupplyValue == "16667200.0", "Available supply value must be \"16667200.0\"")
            XCTAssert(totalSupplyValue == "16667200.0", "Total supply value must be \"16667200.0\"")
        }
    }
}
