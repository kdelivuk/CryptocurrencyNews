//
//  InformationVMProtocol.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 23/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import Defines
import RxSwift

protocol InformationVMProtocol {
    var numberOfItems: Int { get }
    var title: String { get }
    
    var disposeBag: DisposeBag { get }
    
    var stateObservable: Observable<InformationVMState> { get }
    
    func refresh()
    
    func value(for indexPath: IndexPath) -> String
    func title(for indexPath: IndexPath) -> String
}

enum ConcurrencyInformation {
    case rank
    case name
    case symbol
    case priceInFiat(FiatCurrency)
    case priceInBitcoin
    case changeIn1h
    case changeIn24h
    case changeIn7d
    case availableSupply
    case totalSupply
}
