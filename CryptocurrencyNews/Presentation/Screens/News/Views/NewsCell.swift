//
//  NewsCell.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 23/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell, ReusableView, NibLoadableView {
    
    @IBOutlet private weak var rankLabel: UILabel!
    @IBOutlet private weak var symbolLabel: UILabel!
    
    @IBOutlet private weak var priceInFiatLabel: UILabel!
    @IBOutlet private weak var valutChangeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        rankLabel.text = ""
        symbolLabel.text = ""
        priceInFiatLabel.text = ""
        valutChangeLabel.text = ""
    }
    
    func configure(currency: Currency) {
        rankLabel.text = currency.rank
        symbolLabel.text = currency.name
        priceInFiatLabel.text = currency.priceInFiat
        valutChangeLabel.text = currency.change
    }
}
