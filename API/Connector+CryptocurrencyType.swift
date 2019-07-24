//
//  Connector+CryptocurrencyType.swift
//  API
//
//  Created by Kristijan Delivuk on 27/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import RxSwift
import Defines

public protocol CryptocurrencyType {
    func getCryptocurrencies(limit: Int, in currency: FiatCurrency) -> Observable<APIResult<[Cryptocurrency]>>
    func getCryptocurrency(for id: String, in currency: FiatCurrency) -> Observable<APIResult<Cryptocurrency>>
}

extension Connector: CryptocurrencyType {
    public func getCryptocurrencies(limit: Int, in currency: FiatCurrency) -> Observable<APIResult<[Cryptocurrency]>> {
        return Observable<APIResult<[Cryptocurrency]>>.create({ [unowned self] observer in
            self.manager
                .request(Router.getCriptocurrencies(limit: limit, convert: currency))
                .responseJSON(completionHandler: { (response) in
                    switch response.result {
                    case .success(let cryptocurrencyResponse):
                        guard let cryptocurrencyResponseDict = cryptocurrencyResponse as? [[String: Any]] else {
                            observer.onNext(APIResult.error(APIError.invalidServerResponse))
                            observer.onCompleted()
                            return
                        }
                        
                        let cryptocurrencies = cryptocurrencyResponseDict.compactMap({Cryptocurrency(jsonDict: $0, currency: currency)})
                            
                        observer.onNext(APIResult.success(cryptocurrencies))
                        observer.onCompleted()
                    case .failure:
                        observer.onNext(APIResult.error(APIError.internalServerError))
                        observer.onCompleted()
                    }
                })
            return Disposables.create()
        })
    }
    
    public func getCryptocurrency(for id: String, in currency: FiatCurrency) -> Observable<APIResult<Cryptocurrency>> {
        return Observable<APIResult<Cryptocurrency>>.create({ [unowned self] observer in
            self.manager
                .request(Router.getCriptocurrency(id: id, convert: currency))
                .responseJSON(completionHandler: { (response) in
                    switch response.result {
                    case .success(let cryptocurrencyResponse):
                        guard let cryptocurrencyResponseDict = cryptocurrencyResponse as? [[String: Any]],
                        let cryptocurrency = cryptocurrencyResponseDict.flatMap({Cryptocurrency(jsonDict: $0, currency: currency)}).first else {
                            observer.onNext(APIResult.error(APIError.invalidServerResponse))
                            observer.onCompleted()
                            return
                        }
                        
                        observer.onNext(APIResult.success(cryptocurrency))
                        observer.onCompleted()
                        
                    case .failure:
                        observer.onNext(APIResult.error(APIError.internalServerError))
                        observer.onCompleted()
                    }
                })
            return Disposables.create()
        })
    }
}
