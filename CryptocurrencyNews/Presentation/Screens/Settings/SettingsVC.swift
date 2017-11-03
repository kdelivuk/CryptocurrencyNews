//
//  SettingsVC.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 25/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import UIKit
import RxSwift

class SettingsVC: UITableViewController {
    
    // MARK: - Private Properties
    
    fileprivate var mainTableView: SettingsTableView { return view as! SettingsTableView }
    
    fileprivate var currentTextField: UITextField?
    
    fileprivate let disposeBag = DisposeBag()
    
    // MARK: - Class Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = []
        
        title = viewModel.title
        
        mainTableView.rowHeight = 60
        mainTableView.tableFooterView = UIView()
        
        mainTableView.fiatCurrencyPickerView.dataSource = self
        mainTableView.fiatCurrencyPickerView.delegate = self
        
        mainTableView.fiatUnitsTextField.delegate = self
        mainTableView.fiatUnitsTextFieldAccessoryView.delegate = self
        
        mainTableView.limitTextField.delegate = self
        mainTableView.limitTextFieldAccessoryView.delegate = self
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        // set initially selected pickerview currency
        let selectedItemIndex = viewModel.currencies.index(of: viewModel.initialFiatCurrency)
        mainTableView.fiatCurrencyPickerView.selectRow(selectedItemIndex!, inComponent: 0, animated: false)
        
        // set titles for limit and fiat units
        mainTableView.limitTitleLabel.text = viewModel.limitResultsTitle
        mainTableView.fiatUnitsTitleLabel.text = viewModel.fiatCurrencyTitle
        
        // observe changes on currency value and update it accordingly
        viewModel
            .selectedCurrencyObservable
            .subscribe(onNext: { [weak self] currency in
                guard let weakself = self else { return }
                weakself.mainTableView.fiatUnitsTextField.text = currency.title()
            }).disposed(by: disposeBag)
        
        // observe changes on limit value and update it accordingly
        viewModel
            .limitObservable
            .subscribe(onNext: { [weak self] limitValue in
                guard let weakself = self else { return }
                weakself.mainTableView.limitTextField.text = "\(limitValue)"
            }).disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDelegate

extension SettingsVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let selectedItem = viewModel.item(for: indexPath)
        
        switch selectedItem {
        case .fiat:
            mainTableView.fiatUnitsTextField.becomeFirstResponder()
        case .limit:
            mainTableView.limitTextField.becomeFirstResponder()
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.headerTitle
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return viewForFooter()
    }
    
    private func viewForFooter() -> UIView {
        let view = UIView()
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        label.font = Fonts.regular(size: 10)
        label.text = viewModel.footerTitle
        label.textColor = Color.black30
        label.textAlignment = .center
        
        view.addSubview(label)
        
        return view
        
    }
}

// MARK: - UITextFieldDelegate
extension SettingsVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        currentTextField = textField
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let currentTextField = currentTextField else { return }
        
        if currentTextField != mainTableView.limitTextField {
            guard let limitText = mainTableView.limitTextField.text else { return }
            viewModel.changeLimit(to: limitText)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let currentTextField = currentTextField else { return false }

        switch currentTextField.returnKeyType {
        case .next:
            guard let currentIndex = mainTableView.allTextFields.index(of: currentTextField) else { return false }
            mainTableView.allTextFields[currentIndex + 1].becomeFirstResponder()
        case .done:
            currentTextField.resignFirstResponder()
            self.currentTextField = nil
        default:
            print("No action for defined keyboard key.")
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // we enable writing in textfied if it is limit value
        if currentTextField == mainTableView.allTextFields.first {
            return true
        }
        // we disable writing in textfied if it is currency picker
        return false
    }
}

extension SettingsVC: InputAccessoryViewDelegate {
    func textFieldNextButtonPressed(inputAccessoryView: InputAccessoryView) {
        guard let currentIndex = mainTableView.allTextFields.index(of: currentTextField!) else { return }
        
        if currentTextField == mainTableView.allTextFields.last {
            return
        } else {
            mainTableView.allTextFields[currentIndex + 1].becomeFirstResponder()
        }
    }
    
    func textFieldPreviousButtonPressed(inputAccessoryView: InputAccessoryView) {
        guard let currentIndex = mainTableView.allTextFields.index(of: currentTextField!) else { return }
        
        if currentTextField == mainTableView.allTextFields.first {
            return
        } else {
            mainTableView.allTextFields[currentIndex - 1].becomeFirstResponder()
        }
    }
    
    func textFieldDoneButtonPressed(inputAccessoryView: InputAccessoryView) {
        guard let currentTextField = currentTextField else { return }
        currentTextField.resignFirstResponder()
        
        if currentTextField == mainTableView.limitTextField {
            viewModel.changeLimit(to: mainTableView.limitTextField.text ?? "")
        }
        
        self.currentTextField = nil
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension SettingsVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.currencies.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.currencies[row].title()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.selectCurrency(at: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let myTitle = NSAttributedString(
            string: viewModel.currencies[row].title(),
            attributes: [
                NSAttributedStringKey.font: Fonts.regular(size: 16),
                NSAttributedStringKey.foregroundColor: Color.black
            ])
        
        return myTitle
    }
}

// MARK: - StoryboardCompatible

extension SettingsVC: StoryboardCompatible {
    typealias T = SettingsVMProtocol
}
