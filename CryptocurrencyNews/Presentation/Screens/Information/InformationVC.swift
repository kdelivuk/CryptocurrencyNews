//
//  InformationVC.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 23/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import UIKit
import RxSwift

class InformationVC: UIViewController {
    
    private var mainView: InformationView { return view as! InformationView }
    
    private let refreshControl = UIRefreshControl()
    private let emptyStateView = TableViewEmptyStateView()
    private let internetConnectionManager = InternetConnectionManager.shared
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = []
        
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
        mainView.tableView.rowHeight = 60
        mainView.tableView.tableFooterView = UIView()
        
        mainView.tableView.register(InformationCell.self)
        
        refreshControl.addTarget(self, action: #selector(InformationVC.pullToRefreshAction(sender:)), for: .valueChanged)
        
        mainView.tableView.addSubview(refreshControl)
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        title = viewModel.title
        
        viewModel.stateObservable.subscribe(onNext: { [weak self] (viewModelState) in
                guard let weakself = self else { return }
                print("state")
                switch viewModelState {
                case .finished:
                    weakself.mainView.tableView.backgroundView = nil
                    weakself.mainView.tableView.reloadData()
                    weakself.refreshControl.endRefreshing()
                case .error:
                    weakself.mainView.tableView.backgroundView = weakself.emptyStateView
                    weakself.mainView.tableView.reloadData()
                    weakself.refreshControl.endRefreshing()
                case .loading: ()
                }
        }).disposed(by: viewModel.disposeBag)
        
        internetConnectionManager
            .connectionObservable
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] internetAvailable in
                
                guard let weakself = self else { return }
                
                if !internetAvailable {
                    weakself.mainView.tableView.backgroundView = weakself.emptyStateView
                    weakself.emptyStateView.configure(for: .noInternetConnection)
                } else {
                    weakself.mainView.tableView.backgroundView = nil
                }
                
                weakself.mainView.tableView.reloadData()
                weakself.refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)
    }
    
    @objc fileprivate func pullToRefreshAction(sender: UIRefreshControl) {
        viewModel.refresh()
    }
}

extension InformationVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(for: indexPath, type: InformationCell.self)
        let title = viewModel.title(for: indexPath)
        let value = viewModel.value(for: indexPath)
        
        cell.leftTitleLabel.text = title
        cell.rightValueLabel.text = value
        
        return cell
    }
}

extension InformationVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension InformationVC: StoryboardCompatible {
    typealias T = InformationVMProtocol
}
