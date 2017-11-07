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
    
    class var iconArrowDown: UIImage { return UIImage(named: "icon-caret-down")!.withRenderingMode(.alwaysTemplate) }
    class var iconArrowUp: UIImage { return UIImage(named: "icon-caret-up")!.withRenderingMode(.alwaysTemplate) }
    
    class var iconCurrency: UIImage { return UIImage(named: "icon-currency")!.withRenderingMode(.alwaysOriginal) }
    class var iconLimit: UIImage { return UIImage(named: "icon-limit")!.withRenderingMode(.alwaysOriginal) }
    
    class var iconSearch: UIImage { return UIImage(named: "icon-search")!.withRenderingMode(.alwaysOriginal) }
}
