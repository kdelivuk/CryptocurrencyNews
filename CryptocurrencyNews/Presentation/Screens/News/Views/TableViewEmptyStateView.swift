//
//  TableViewEmptyStateView.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 26/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import UIKit
import SnapKit

enum TableViewEmptyStateViewState {
    case noInternetConnection
    case error
    case noSearchResults
}

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
        titleLabel.textAlignment = .center
        
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
    func configure(for state: TableViewEmptyStateViewState) {
        switch state {
        case .noInternetConnection:
            titleLabel.text = "No internet connection"
        case .error:
            titleLabel.text = "Server error"
        case .noSearchResults:
            titleLabel.text = "No search results"
        }
    }
}
