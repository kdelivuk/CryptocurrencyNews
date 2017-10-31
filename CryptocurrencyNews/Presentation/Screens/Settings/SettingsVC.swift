//
//  SettingsVC.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 25/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    private var mainView: SettingsView { return view as! SettingsView }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = []
        
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
        mainView.tableView.rowHeight = 60
        mainView.tableView.tableFooterView = UIView()
        
        mainView.tableView.register(SettingsCell.self)
    }
}

extension SettingsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(for: indexPath, type: SettingsCell.self)
        let item = viewModel.item(for: indexPath)
        
        cell.configure(with: item)
        
        return cell
    }
}

extension SettingsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        viewModel.didSelectItem(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Settings"
    }
}


extension SettingsVC: StoryboardCompatible {
    typealias T = SettingsVMProtocol
}
