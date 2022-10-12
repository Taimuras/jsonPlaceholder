//
//  PhotosViewController.swift
//  JsonPlaceholder
//
//  Created by Timur on 12/10/22.
//

import UIKit

class PhotosViewController: BaseViewController{
    private lazy var titleLabel = BaseLabel(type: .title)
    
    private lazy var mainСollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: UICollectionViewLayout())
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
        return collectionView
    }()
    
    private var pullToRefresh: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.attributedTitle = NSAttributedString(string: "Pull to refresh")
        rc.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return rc
    }()
    
    var user: UserModel
    var viewModel: PhotosViewModelProtocol
    
    init(
        user: UserModel,
        album: AlbumModel,
        viewModel: PhotosViewModelProtocol = PhotosViewModel()
    ){
        self.user = user
        self.viewModel = viewModel
        super.init(navigationType: .photosScreen)
        self.viewModel.album = album
        self.viewModel.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViews() {
        super.setupViews()
        view.addSubviews(titleLabel, mainСollectionView)
        
        mainСollectionView.addSubview(pullToRefresh)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        titleLabelConstraints()
        mainCollectionViewConstraints()
    }
    
    override func setupValues() {
        super.setupValues()
        viewModel.view = self
        viewModel.register(collectionView: mainСollectionView)
        viewModel.isLoadingComp = { [weak self] (isLoading) in
            if isLoading{
                self?.startLoading()
            } else{
                self?.pullToRefresh.endRefreshing()
                self?.stopLoading()
            }
        }
        
        if let name = user.name{
            titleLabel.text = "\(name.capitalized)'s photos"
        }
    }
    
    private func titleLabelConstraints(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 24)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func mainCollectionViewConstraints(){
        mainСollectionView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            mainСollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainСollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainСollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            mainСollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -safeAreaBottomHeight - 10)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getImages()
    }
    
    @objc private func refresh() {
        getImages()
    }
    
    func getImages(){
        viewModel.getAllImages()
    }
}
