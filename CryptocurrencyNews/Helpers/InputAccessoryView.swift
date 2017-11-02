//
//  InputAccessoryView.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 31/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import UIKit

protocol InputAccessoryViewDelegate: class {
    func textFieldNextButtonPressed(inputAccessoryView: InputAccessoryView)
    func textFieldPreviousButtonPressed(inputAccessoryView: InputAccessoryView)
    func textFieldDoneButtonPressed(inputAccessoryView: InputAccessoryView)
}

class InputAccessoryView: UIView {
    private struct Constants {
        static let textDoneButton = NSLocalizedString("Done", comment: "InputAccessoryView.DoneButton")
    }
    
    let doneButton: UIButton
    let nextButton: UIButton
    let previousButton: UIButton
    
    weak var delegate: InputAccessoryViewDelegate?
    
    override init(frame: CGRect) {
        doneButton = UIButton()
        nextButton = UIButton()
        previousButton = UIButton()
        super.init(frame: frame)
        commonInit()
    }
    
    fileprivate func commonInit() {
        self.backgroundColor = Color.white
        
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(Color.black, for: .normal)
        nextButton.addTarget(self, action: #selector(nextTextFieldButtonAction), for: UIControlEvents.touchUpInside)
        
        previousButton.setTitle("Prev", for: .normal)
        previousButton.setTitleColor(Color.black, for: .normal)
        previousButton.addTarget(self, action: #selector(previousTextFieldButtonAction), for: UIControlEvents.touchUpInside)
        
        doneButton.setTitle(Constants.textDoneButton, for: .normal)
        doneButton.setTitleColor(Color.black, for: .normal)
        doneButton.titleLabel?.font = Fonts.regular(size: 16)
        doneButton.addTarget(self, action: #selector(doneTextFieldButtonAction), for: UIControlEvents.touchUpInside)
        
        let stretchableView = UIView()
        let spacingView1 = UIView()
        let spacingView2 = UIView()
        let spacingView3 = UIView()
        
        let stackView = UIStackView(arrangedSubviews: [spacingView1, previousButton, spacingView2, nextButton, stretchableView, doneButton, spacingView3])
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        spacingView1.snp.makeConstraints { (make) in
            make.width.equalTo(16)
        }
        
        spacingView2.snp.makeConstraints { (make) in
            make.width.equalTo(16)
        }
        
        spacingView3.snp.makeConstraints { (make) in
            make.width.equalTo(16)
        }
    }
    
    func removeNavigationButtons(){
        nextButton.isHidden = true
        previousButton.isHidden = true
    }
    
    func setButtonDisabled(sender: UIButton) {
        sender.isEnabled = false
        sender.setTitleColor(Color.black50, for: .normal)
    }
    
    func setButtonEnabled(sender: UIButton) {
        sender.isEnabled = true
        sender.setTitleColor(Color.black50, for: .normal)
    }
    
    @objc private func nextTextFieldButtonAction(sender: UIButton) {
        delegate?.textFieldNextButtonPressed(inputAccessoryView: self)
    }
    
    @objc private func previousTextFieldButtonAction(sender: UIButton) {
        delegate?.textFieldPreviousButtonPressed(inputAccessoryView: self)
    }
    
    @objc private func doneTextFieldButtonAction(sender: UIButton) {
        delegate?.textFieldDoneButtonPressed(inputAccessoryView: self)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        let size = CGSize(width: UIViewNoIntrinsicMetric, height: 44)
        return size
    }
}
