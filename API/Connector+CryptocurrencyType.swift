//
//  Connector+CryptocurrencyType.swift
//  API
//
//  Created by Kristijan Delivuk on 27/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import RxSwift

public protocol CryptocurrencyType {
    func getCryptocurrencies(limit: Int, in currency: Currency) -> Observable<APIResult<[Cryptocurrency]>>
}

extension Connector: CryptocurrencyType {
    public func getCryptocurrencies(limit: Int, in currency: Currency) -> Observable<APIResult<[Cryptocurrency]>> {
        return Observable<APIResult<[Cryptocurrency]>>.create({ [unowned self] observer in
            self.manager
                .request(Router.getCriptocurrencies(limit: limit, convert: currency))
                .responseJSONCollection(expectedType: Cryptocurrency.self, completionHandler: { (response) in
                    switch response.result {
                    case .success(let cryptocurrencyResponse):
                        observer.onNext(APIResult.success(cryptocurrencyResponse))
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onNext(APIResult.error(error as! APIError))
                        observer.onCompleted()
                    }
                })
            return Disposables.create()
        })
    }
}
