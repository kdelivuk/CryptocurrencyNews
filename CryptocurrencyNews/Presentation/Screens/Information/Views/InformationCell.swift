//
//  InformationCell.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 02/11/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import UIKit

class InformationCell: UITableViewCell, NibLoadableView, ReusableView {
    
    @IBOutlet weak var leftTitleLabel: UILabel!
    @IBOutlet weak var rightValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        leftTitleLabel.font = Fonts.bold(size: 14)
        leftTitleLabel.textColor = Color.black
        leftTitleLabel.lineBreakMode = .byTruncatingTail
        leftTitleLabel.textAlignment = .left
        
        rightValueLabel.textColor = Color.black30
        rightValueLabel.textAlignment = .right
        rightValueLabel.font = Fonts.regular(size: 18)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        leftTitleLabel.text = ""
        rightValueLabel.text = ""
    }
}
