//
//  UsersScreenViewController.swift
//  JsonPlaceholder
//
//  Created by Timur on 11/10/22.
//

import UIKit

class UsersScreenViewController: BaseViewController{
    private lazy var usersTableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = 88
        tv.dataSource = viewModel
        tv.delegate = viewModel
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        return tv
    }()
    
    private var pullToRefresh: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.attributedTitle = NSAttributedString(string: "Pull to refresh")
        rc.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return rc
    }()
    
    var viewModel: UsersScreenViewModelProtocol
    init(viewModel: UsersScreenViewModelProtocol = UsersScreenViewModel()){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViews() {
        super.setupViews()
        view.addSubview(usersTableView)
        usersTableView.addSubview(pullToRefresh)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        usersTableView.translatesAutoresizingMaskIntoConstraints = false
        let usersTableViewConstraints = [
            usersTableView.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: 4),
            usersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            usersTableView.trailingAnchor.constraint(equalTo: navigationView.trailingAnchor, constant: 0),
            usersTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -safeAreaBottomHeight - 10)
        ]
        NSLayoutConstraint.activate(usersTableViewConstraints)
    }
    
    override func setupValues() {
        super.setupValues()
        viewModel.view = self
        viewModel.registerTableView(usersTableView)
        viewModel.isLoadingComp = { [weak self] (isLoading) in
            if isLoading{
                self?.startLoading()
            } else{
                self?.pullToRefresh.endRefreshing()
                self?.stopLoading()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getAllUser()
    }
    
    @objc private func refresh() {
        viewModel.getAllUser()
    }
}
