//
//  Router.swift
//  API
//
//  Created by Kristijan Delivuk on 24/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import Foundation
import Alamofire

enum Router {
    
    case getCriptocurrencies(limit: Int, convert: FiatCurrency)
    
    fileprivate var baseURL: URL {
        return URL(string: "")!
    }
    
    var path: String {
        switch self {
        case .getCriptocurrencies:
            return "ticker/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCriptocurrencies:
            return .get
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .getCriptocurrencies:
            return URLEncoding.default
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .getCriptocurrencies(let limit, let currency):
            return [
                "limit": limit,
                "convert": currency.rawValue.uppercased()
            ]
        }
    }
}

extension Router: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        
        let urlEncodedPath = URLEncoding.default.escape(path)
        
        let urlString = baseURL.absoluteString + urlEncodedPath
        
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let requestConvertible =  try parameterEncoding.encode(request, with: parameters)
        return requestConvertible
    }
}
