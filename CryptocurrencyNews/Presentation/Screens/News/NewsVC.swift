//
//  NewsVC.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 23/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import UIKit

class NewsVC: UIViewController {
    
    fileprivate var mainView: NewsView { return view as! NewsView }
    private let refreshControl = UIRefreshControl()
    private let emptyStateView = TableViewEmptyStateView()
    
    private var loaderVC: FullScreenLoaderVC?
    
    fileprivate var keyboardHeight: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = []
        
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
        mainView.tableView.rowHeight = 60
        mainView.tableView.tableFooterView = UIView()
        
        mainView.tableView.register(NewsCell.self)
        
        refreshControl.addTarget(self, action: #selector(NewsVC.pullToRefreshAction(sender:)), for: .valueChanged)
        
        mainView.tableView.addSubview(refreshControl)
        
        mainView.searchBar.delegate = self
        mainView.searchBar.resignFirstResponder()
        
        bindViewModel()
        
        viewModel.top()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private func bindViewModel() {
        viewModel
            .stateObservable
            .subscribe(onNext: { [weak self] viewModelState in
                guard let weakself = self else { return }
                print("current state: \(viewModelState)")
                switch viewModelState {
                case .top:
                    
                    if let loaderVC = weakself.loaderVC {
                        loaderVC.stopAnimating()
                        loaderVC.removeChildVCFromParentViewController()
                        weakself.loaderVC = nil
                    }
                    
                    weakself.mainView.tableView.backgroundView = nil
                    // reload signal
                    weakself.refreshControl.endRefreshing()
                    weakself.mainView.tableView.reloadData()
                    
                case .search(let searchState):
                    switch searchState {
                    case .empty:
                        
                        if let loaderVC = weakself.loaderVC {
                            loaderVC.stopAnimating()
                            loaderVC.removeChildVCFromParentViewController()
                            weakself.loaderVC = nil
                        }
                        
                        weakself.mainView.tableView.backgroundView = weakself.emptyStateView
                        weakself.emptyStateView.configure(for: .noSearchResults)
                        // reload signal
                        weakself.refreshControl.endRefreshing()
                        weakself.mainView.tableView.reloadData()
                    case .searching:
                        
                        // removing background view from tableview subview
                        weakself.mainView.tableView.backgroundView = nil
                        
                        // initializing loader viewcontroller
                        weakself.loaderVC = FullScreenLoaderVC()
                        guard let loaderVC = weakself.loaderVC else { return }
                        
                        // adding loader viewcontroller to subview as child
                        weakself.attachChildVC(loaderVC)
                        loaderVC.view.snp.makeConstraints({ (make) in
                            make.top.equalTo(weakself.mainView.searchBar.snp.bottom)
                            make.left.right.equalTo(0)
                            make.bottom.equalTo(-(weakself.keyboardHeight ?? 0))
                        })
                        
                        
                    case .results:
                        
                        if let loaderVC = weakself.loaderVC {
                            loaderVC.stopAnimating()
                            loaderVC.removeChildVCFromParentViewController()
                            weakself.loaderVC = nil
                        }
                        
                        weakself.mainView.tableView.backgroundView = nil
                        // reload signal
                        weakself.refreshControl.endRefreshing()
                        weakself.mainView.tableView.reloadData()
                    case .error:
                        // reload signal
                        weakself.refreshControl.endRefreshing()
                        weakself.mainView.tableView.reloadData()
                    }
                }
            }).disposed(by: viewModel.disposeBag)
        
        viewModel
            .titleObservable
            .subscribe(onNext: { [weak self] title in
                guard let weakself = self else { return }
                weakself.title = title
            }).disposed(by: viewModel.disposeBag)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Private Selector Actions
    
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
            let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size else {
                return
        }
        
        let tabbarHeight = tabBarController?.tabBar.frame.size.height ?? 0
        
        keyboardHeight = keyboardSize.height - tabbarHeight

        configureViewForKeyboardWillShowAction(with: keyboardHeight ?? 0)
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        configureViewForKeyboardWillHideAction(with: keyboardHeight ?? 0)
    }
    
    @objc fileprivate func pullToRefreshAction(sender: UIRefreshControl) {
        viewModel.search(word: mainView.searchBar.text ?? "")
    }
    
    private func configureViewForKeyboardWillShowAction(with size: CGFloat) {
        mainView.tableViewBottomConstraint.constant += size
    }
    
    private func configureViewForKeyboardWillHideAction(with size: CGFloat) {
        mainView.tableViewBottomConstraint.constant -= size
    }
}

extension NewsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(for: indexPath, type: NewsCell.self)
        let currency = viewModel.item(for: indexPath)
        let priceInFiat = viewModel.priceInFiat
        
        cell.configure(currency: currency, priceInFiat: priceInFiat)
        
        return cell
    }
}

extension NewsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        viewModel.didSelectItem(at: indexPath)
    }
}

extension NewsVC: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        mainView.searchBar.clear()
        viewModel.top()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        searchBar.showsCancelButton = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // clearing the results
        viewModel.clear()
        mainView.tableView.reloadData()
        
        // searching for filtered results
        viewModel.search(word: searchText)
    }
}

extension NewsVC: StoryboardCompatible {
    typealias T = NewsVMProtocol
}
