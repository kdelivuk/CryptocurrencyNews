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
    private let imageView: UIImageView
    
    override init(frame: CGRect) {
        self.titleLabel = UILabel()
        self.imageView = UIImageView()
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        
        imageView.contentMode = .scaleAspectFill
        
        titleLabel.font = Fonts.regular(size: 18)
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .center
        
        let topView = UIView()
        let bottomView = UIView()
        
        let spacingView = UIView()
        
        let stackView = UIStackView(arrangedSubviews: [topView, imageView, spacingView, titleLabel, bottomView])
        stackView.axis = .vertical
        stackView.alignment = .center
        
        addSubview(stackView)
        
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(64)
        }
        
        spacingView.snp.makeConstraints { (make) in
            make.height.equalTo(15)
        }
        
        topView.snp.makeConstraints { (make) in
            make.height.equalTo(bottomView)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
    func configure(for state: TableViewEmptyStateViewState) {
        switch state {
        case .noInternetConnection:
            imageView.image = nil
            titleLabel.text = "No internet connection"
        case .error:
            imageView.image = nil
            titleLabel.text = "Server error"
        case .noSearchResults:
            imageView.image = Images.iconSearch
            titleLabel.text = "No search results"
        }
    }
}
