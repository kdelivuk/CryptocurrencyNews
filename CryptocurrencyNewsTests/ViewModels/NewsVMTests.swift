//
//  NewsVMTests.swift
//  CryptocurrencyNewsTests
//
//  Created by Kristijan Delivuk on 06/11/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking

@testable import CryptocurrencyNews

class NewsVMTests: XCTestCase {
    
    // Private method used for injecting VM
    // into other test methods
    private func prepareVM(block: (NewsVM) -> ()) {
        let cryptocurrencyManagerMock = CryptocurrencyManagerMock()
        let newsVM = NewsVM(cryptocurrencyManager: cryptocurrencyManagerMock)
        
        block(newsVM)
    }
    
    // Test case
    // ---------
    // Initial state must be equal to Top 100
    func testInitialStateIsEqualToTop100() {
        prepareVM { (newsVM) in
        let state = try! newsVM.stateObservable.toBlocking(timeout: 10.0).first()!
            
            XCTAssert(state == NewsVMState.top([]), "State must be equal to top 100")
        }
    }
    
    // Test case
    // ---------
    // Initial title must be equal to "Top 100"
    func testInitialTitleIsEqualToTop100() {
        prepareVM { (newsVM) in
            let title = try! newsVM.titleObservable.toBlocking(timeout: 10.0).first()!
            
            XCTAssert(title == "Top 100", "Title must be equal to top 100")
        }
    }
    
    // Test case
    // ---------
    // Initial fiat price must be set to USD
    func testInitialFiatCurrencyIsSetToUSD() {
        prepareVM { (newsVM) in
            let priceInFiat = newsVM.priceInFiat
            XCTAssert(priceInFiat == "Price in USD", "Price in fiat must be set to USD.")
        }
    }
}
