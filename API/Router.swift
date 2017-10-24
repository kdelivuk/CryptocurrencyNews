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
    
    fileprivate var baseURL: URL {
        return URL(string: "")!
    }
    
    var path: String {
        return ""
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var parameters: Parameters {
        return [:]
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
