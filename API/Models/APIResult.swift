//
//  APIResult.swift
//  API
//
//  Created by Kristijan Delivuk on 24/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import Foundation

public enum APIResult<T> {
    case success(T)
    case error(APIError)
}
