//
//  NSObject+Extension.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 25/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import Foundation

extension NSObject {
    var objectName: String {
        return String(describing: type(of: self))
    }
}
