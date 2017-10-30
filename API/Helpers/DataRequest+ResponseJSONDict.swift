//
//  DataRequest+ResponseJSONDict.swift
//  API
//
//  Created by Kristijan Delivuk on 30/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import Foundation
import Alamofire

extension Result {
    
    public var apiError: APIError? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error as? APIError
        }
    }
}


extension DataRequest {
    /// Creates a response serializer that returns a JSON object result type constructed from the response data using
    /// `JSONSerialization` with the specified reading options.
    ///
    /// - parameter options: The JSON serialization reading options. Defaults to `.allowFragments`.
    ///
    /// - returns: A JSON object response serializer.
    static func jsonResponseCollection<T: JSONDecodable>(
        options: JSONSerialization.ReadingOptions = .allowFragments)
        -> DataResponseSerializer<[T]>
    {
        
        return DataResponseSerializer { _, response, data, error in
            let aa = Request.serializeResponseJSON(options: options, response: response, data: data, error: error)
            if let dicts = aa.value as? [[String : Any]]{
                let objects = dicts.flatMap({ (jsonDict) -> T? in
                    let object = T.init(jsonDict: jsonDict)
                    return object
                })
                return Result<[T]>.success(objects)
            } else if let error = error {
                return Result<[T]>.failure(error)
            } else {
                return Result<[T]>.failure(APIError.invalidServerResponse)
            }
        }
    }
    
    /// Adds a handler to be called once the request has finished.
    ///
    /// - parameter options:           The JSON serialization reading options. Defaults to `.allowFragments`.
    /// - parameter completionHandler: A closure to be executed once the request has finished.
    ///
    /// - returns: The request.
    @discardableResult
    func responseJSONCollection<T: JSONDecodable>(
        expectedType: T.Type,
        queue: DispatchQueue? = nil,
        options: JSONSerialization.ReadingOptions = .allowFragments,
        completionHandler: @escaping (DataResponse<[T]>) -> Void)
        -> Self
    {
        return response(
            queue: queue,
            responseSerializer: DataRequest.jsonResponseCollection(options: options),
            completionHandler: completionHandler
        )
    }
}
