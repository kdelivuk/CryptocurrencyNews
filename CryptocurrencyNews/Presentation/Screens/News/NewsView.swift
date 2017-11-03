//
//  NewsView.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 23/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import UIKit

class NewsView: UIView {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        searchBar.searchBarStyle = UISearchBarStyle.minimal
        searchBar.tintColor = Color.green

        searchBar.placeholder = NSLocalizedString("Search", comment: "NewsView.searchBar.placeholder")
    }
}
