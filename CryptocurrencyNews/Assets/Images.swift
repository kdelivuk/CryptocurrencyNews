//
//  Images.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 23/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import UIKit

final class Images {
    
    // MARK: - Tabbar icons
    
    class var iconSettings: UIImage { return UIImage(named: "icon-settings")! }
    class var iconStock: UIImage { return UIImage(named: "icon-stock")! }
    
    // MARK: - Reusable icons
    
    class var iconArrowDown: UIImage { return UIImage(named: "icon-arrow-down")!.withRenderingMode(.alwaysTemplate) }
}
