//
//  APIError.swift
//  API
//
//  Created by Kristijan Delivuk on 24/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import Foundation

public enum APIError: Error {
    case invalidServerResponse //if server response cannot be correctly parsed
    case internalServerError // 500+
    case invalidServerRequest // 400-500
    case noInternetConnection
    case alreadyUsedHandle
}
