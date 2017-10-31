//
//  Fonts.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 31/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import Foundation
import UIKit

final class Fonts {
    
    class func regular(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
    
    class func bold(size: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size)
    }
}
