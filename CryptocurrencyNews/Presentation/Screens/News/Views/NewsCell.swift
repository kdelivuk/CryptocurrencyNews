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
    
    @IBOutlet weak var priceInFiatTitleLabel: UILabel!
    @IBOutlet private weak var priceInFiatLabel: UILabel!
    
    
    @IBOutlet weak var valutChangeTitleLabel: UILabel!
    @IBOutlet private weak var valutChangeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        rankLabel.font = Fonts.bold(size: 26)
        rankLabel.textColor = Color.black
        rankLabel.lineBreakMode = .byTruncatingTail
        rankLabel.textAlignment = .center
        
        symbolLabel.font = Fonts.bold(size: 14)
        symbolLabel.textColor = Color.black50
        symbolLabel.lineBreakMode = .byTruncatingTail
        symbolLabel.textAlignment = .center
        
        priceInFiatLabel.font = Fonts.bold(size: 16)
        priceInFiatLabel.textColor = Color.black50
        priceInFiatLabel.lineBreakMode = .byTruncatingTail
        priceInFiatLabel.textAlignment = .right
        
        priceInFiatTitleLabel.font = Fonts.bold(size: 12)
        priceInFiatTitleLabel.textColor = Color.black
        priceInFiatTitleLabel.lineBreakMode = .byTruncatingTail
        priceInFiatTitleLabel.textAlignment = .left
        
        valutChangeTitleLabel.font = Fonts.bold(size: 12)
        valutChangeTitleLabel.textColor = Color.black
        valutChangeTitleLabel.lineBreakMode = .byTruncatingTail
        valutChangeTitleLabel.textAlignment = .left
        
        valutChangeLabel.font = Fonts.bold(size: 16)
        valutChangeLabel.textColor = Color.black50
        valutChangeLabel.lineBreakMode = .byTruncatingTail
        valutChangeLabel.textAlignment = .right
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
        valutChangeLabel.text = "\(currency.changeIn24h * 100)%"
        
        if currency.changeIn24h > 0.0 {
            valutChangeLabel.textColor = .green
        } else {
            valutChangeLabel.textColor = .red
        }
    }
}
