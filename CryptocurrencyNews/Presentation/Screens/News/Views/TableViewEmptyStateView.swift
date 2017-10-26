//
//  TableViewEmptyStateView.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 26/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import UIKit
import SnapKit

class TableViewEmptyStateView: UIView {
    
    private let titleLabel: UILabel
    
    override init(frame: CGRect) {
        self.titleLabel = UILabel()
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        titleLabel.numberOfLines = 1
        titleLabel.text = "No results"
        titleLabel.textAlignment = .center
        
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
}
