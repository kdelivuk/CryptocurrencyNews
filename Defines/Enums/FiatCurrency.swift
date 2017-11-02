//
//  FiatCurrency.swift
//  Defines
//
//  Created by Kristijan Delivuk on 31/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import Foundation

public enum FiatCurrency: String, RawRepresentable {
    
    public typealias RawValue = String
    
    case usd
    case eur
    case cny
    
    public func title() -> String {
        return self.rawValue.uppercased()
    }
    
    public init?(rawValue: String) {
        switch rawValue {
        case "usd":
            self = .usd
        case "eur":
            self = .eur
        case "cny":
            self = .cny
        default:
            return nil
        }
    }
}
