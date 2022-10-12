//
//  AlbumsViewController.swift
//  JsonPlaceholder
//
//  Created by Timur on 12/10/22.
//

import UIKit

class AlbumsViewController: BaseViewController{
    private lazy var usersMainView: UIView = {
        let view = UIView()
        view.backgroundColor = .navigationBG
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var userImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = .personIconImage
        return iv
    }()
    
    private lazy var userNameLabel = BaseLabel(type: .userName)
    
    private lazy var albumsTableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = 80
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
    
    var user: UserModel
    var viewModel: AlbumsViewModelProtocol
    
    init(
        user: UserModel,
        viewModel: AlbumsViewModelProtocol = AlbumsViewModel()
    ){
        self.user = user
        self.viewModel = viewModel
        super.init(navigationType: .albumsScreen)
        self.viewModel.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViews() {
        super.setupViews()
        view.addSubviews(usersMainView, albumsTableView)
        usersMainView.addSubviews(userImageView, userNameLabel)
        
        albumsTableView.addSubview(pullToRefresh)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        usersConstraints()
        albumsTableViewConstraints()
    }
    
    override func setupValues() {
        super.setupValues()
        viewModel.view = self
        viewModel.registerTableView(albumsTableView)
        viewModel.isLoadingComp = { [weak self] (isLoading) in
            if isLoading{
                self?.startLoading()
            } else{
                self?.pullToRefresh.endRefreshing()
                self?.stopLoading()
            }
        }
        
        if let name = user.name{
            userNameLabel.text = name
        }
    }
    
    private func usersConstraints(){
        usersMainView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        let usersMainViewConstraints = [
            usersMainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            usersMainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            usersMainView.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: 10),
            usersMainView.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(usersMainViewConstraints)
        
        let userNameLabelConstraints = [
            userNameLabel.centerXAnchor.constraint(equalTo: usersMainView.centerXAnchor),
            userNameLabel.topAnchor.constraint(equalTo: usersMainView.topAnchor, constant: 10),
            userNameLabel.bottomAnchor.constraint(equalTo: usersMainView.bottomAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(userNameLabelConstraints)
        
        let userImageViewConstraints = [
            userImageView.trailingAnchor.constraint(equalTo: userNameLabel.leadingAnchor, constant: -10),
            userImageView.topAnchor.constraint(equalTo: usersMainView.topAnchor, constant: 10),
            userImageView.bottomAnchor.constraint(equalTo: usersMainView.bottomAnchor, constant: -10),
            userImageView.widthAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(userImageViewConstraints)
    }
    
    private func albumsTableViewConstraints(){
        albumsTableView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            albumsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            albumsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            albumsTableView.topAnchor.constraint(equalTo: usersMainView.bottomAnchor, constant: 20),
            albumsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -safeAreaBottomHeight - 20)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getData()
    }
    
    @objc private func refresh() {
        viewModel.getData()
    }
}
