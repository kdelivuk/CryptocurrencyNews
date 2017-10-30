//
//  JSONDecodable.swift
//  API
//
//  Created by Kristijan Delivuk on 27/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import Foundation

protocol JSONDecodable {
    
    init?(jsonDict: [String: Any])
    
}
