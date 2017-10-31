//
//  SettingsCell.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 31/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell, ReusableView, NibLoadableView {
    
    @IBOutlet weak var fiatUnitsTitleLabel: UILabel!
    @IBOutlet weak var fiatUnitsLabel: UILabel!
    @IBOutlet weak var accessoryImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        fiatUnitsTitleLabel.font = Fonts.bold(size: 16)
        fiatUnitsTitleLabel.textColor = Color.black
        fiatUnitsTitleLabel.lineBreakMode = .byTruncatingTail
        fiatUnitsTitleLabel.textAlignment = .left
        
        fiatUnitsTitleLabel.font = Fonts.regular(size: 16)
        fiatUnitsTitleLabel.textColor = Color.black50
        fiatUnitsTitleLabel.lineBreakMode = .byTruncatingTail
        fiatUnitsTitleLabel.textAlignment = .center
        
        accessoryImageView.image = Images.iconArrowDown
        accessoryImageView.contentMode = .scaleAspectFit
        accessoryImageView.tintColor = Color.black50
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        
    }
    
    func configure(with item: SettingsVMItem) {
        fiatUnitsTitleLabel.text = item.configure()
    }
}
