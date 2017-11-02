//
//  SettingsTableView.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 25/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import UIKit

class SettingsTableView: UITableView {
    
    @IBOutlet weak var limitTitleLabel: UILabel!
    @IBOutlet weak var limitTextField: UITextField!
    @IBOutlet weak var limitImageView: UIImageView!
    
    @IBOutlet weak var fiatUnitsTitleLabel: UILabel!
    @IBOutlet weak var fiatUnitsTextField: UITextField!
    @IBOutlet weak var fiatUnitsImageView: UIImageView!
    
    let fiatCurrencyPickerView = UIPickerView()
    
    lazy var limitTextFieldAccessoryView: InputAccessoryView = {
        let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 44)
        let accessoryView = InputAccessoryView(frame: frame)
        return accessoryView
    }()
    
    lazy var fiatUnitsTextFieldAccessoryView: InputAccessoryView = {
        let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 44)
        let accessoryView = InputAccessoryView(frame: frame)
        return accessoryView
    }()
    
    var allTextFields: [UITextField] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // set all text fields into an array so we can configure accessory view
        allTextFields = [limitTextField, fiatUnitsTextField]
        
        // configure label displaying fiat units title
        fiatUnitsTitleLabel.font = Fonts.bold(size: 14)
        fiatUnitsTitleLabel.textColor = Color.black
        fiatUnitsTitleLabel.lineBreakMode = .byTruncatingTail
        fiatUnitsTitleLabel.textAlignment = .left
        
        // configure label displaying limit title
        limitTitleLabel.font = Fonts.bold(size: 14)
        limitTitleLabel.textColor = Color.black
        limitTitleLabel.lineBreakMode = .byTruncatingTail
        limitTitleLabel.textAlignment = .left
        
        // configure text field used for entering fiat units
        fiatUnitsTextField.returnKeyType = .done
        fiatUnitsTextField.inputView = fiatCurrencyPickerView
        fiatUnitsTextField.textColor = Color.black30
        fiatUnitsTextField.inputAccessoryView = fiatUnitsTextFieldAccessoryView
        fiatUnitsTextField.textAlignment = .center
        fiatUnitsTextField.font = Fonts.regular(size: 18)
        
        // configure text field used for entering limit
        limitTextField.textAlignment = .center
        limitTextField.font = Fonts.regular(size: 18)
        limitTextField.textColor = Color.black30
        limitTextField.inputAccessoryView = limitTextFieldAccessoryView
        limitTextField.keyboardType = .numberPad
        limitTextField.returnKeyType = .next
        
        // configure image view displaying accessory arrow for fiat units
        fiatUnitsImageView.image = Images.iconCurrency
        fiatUnitsImageView.contentMode = .scaleAspectFit
        
        // configure image view displaying accessory arrow for limit
        limitImageView.image = Images.iconLimit
        limitImageView.contentMode = .scaleAspectFit
        
        // disable accessory view next and previous buttons
        fiatUnitsTextFieldAccessoryView.setButtonDisabled(sender: fiatUnitsTextFieldAccessoryView.nextButton)
        limitTextFieldAccessoryView.setButtonDisabled(sender: limitTextFieldAccessoryView.previousButton)
    }
}
