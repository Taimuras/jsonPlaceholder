//
//  SinglePhotoViewController.swift
//  JsonPlaceholder
//
//  Created by Timur on 12/10/22.
//

import UIKit

class SinglePhotoViewController: BaseViewController{
    private lazy var labelsMainView: UIView = {
        let view = UIView()
        view.backgroundColor = .navigationBG
        return view
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fillProportionally
        stack.backgroundColor = .navigationBG
        return stack
    }()
    
    private lazy var userNameLabel = BaseLabel(type: .photoUserTitle)
    
    private lazy var albumTitleLabel = BaseLabel(type: .photoAlbumTitle)
    
    private lazy var photoTitleLabel = BaseLabel(type: .photoTitle)
    
    private lazy var topEmptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var bottomEmptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var mainImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .clear
        iv.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    var user: UserModel
    var album: AlbumModel
    var photo: PhotoModel
    var viewModel: SinglePhotoViewModelProtocol
    
    var isOverlayHidden: Bool = true
    
    init(
        user: UserModel,
        album: AlbumModel,
        photo: PhotoModel,
        viewModel: SinglePhotoViewModelProtocol = SinglePhotoViewModel()
    ) {
        self.user = user
        self.album = album
        self.photo = photo
        self.viewModel = viewModel
        super.init(navigationType: .signlePhotoScreen)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViews() {
        super.setupViews()
        
        navigationView.transform = CGAffineTransform(translationX: 1, y: -safeAreatopHeight - 50)
        labelsMainView.transform = CGAffineTransform(translationX: 1, y: screenHeight / 2)
        
        view.addSubviews(labelsMainView)
        view.insertSubview(mainImageView, at: 0)
        labelsMainView.addSubview(labelsStackView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        mainImageViewConstraints()
        labelsMainViewConstraints()
        labelsStackViewConstraints()
        emptyViewsConstraints()
    }
    
    override func setupValues() {
        super.setupValues()
        
        if let userName = user.name{
            userNameLabel.text = userName.capitalized
        }
        
        if let albumTitle = album.title{
            albumTitleLabel.text = albumTitle.capitalized
        }
        
        if let photoTitle = photo.title{
            photoTitleLabel.text = photoTitle.capitalized
        }
        
        guard let url = photo.url else {return}
        getData(urlString: url)
    }
    
    private func getData(urlString: String){
        viewModel.getSingleImage(urlString: urlString) { [weak self] (imageData) in
            DispatchQueue.main.async {
                self?.mainImageView.image = UIImage(data: imageData)
            }
        }
    }
    
    private func mainImageViewConstraints(){
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            mainImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mainImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mainImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: safeAreatopHeight + 10),
            mainImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -safeAreaBottomHeight - 10)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func labelsMainViewConstraints(){
        labelsMainView.translatesAutoresizingMaskIntoConstraints = false
        let labelsMainViewConstraints = [
            labelsMainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            labelsMainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            labelsMainView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(labelsMainViewConstraints)
    }
    
    private func labelsStackViewConstraints(){
        [topEmptyView, userNameLabel, albumTitleLabel, photoTitleLabel, bottomEmptyView].forEach{labelsStackView.addArrangedSubview($0)}
        
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        let labelsStackViewConstraints = [
            labelsStackView.leadingAnchor.constraint(equalTo: labelsMainView.leadingAnchor, constant: 16),
            labelsStackView.trailingAnchor.constraint(equalTo: labelsMainView.trailingAnchor, constant: -16),
            labelsStackView.bottomAnchor.constraint(equalTo: labelsMainView.bottomAnchor, constant: 0),
            labelsStackView.topAnchor.constraint(equalTo: labelsMainView.topAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(labelsStackViewConstraints)
    }
    
    private func emptyViewsConstraints(){
        bottomEmptyView.translatesAutoresizingMaskIntoConstraints = false
        let bottomEmptyViewConstraints = [
            bottomEmptyView.heightAnchor.constraint(equalToConstant: safeAreaBottomHeight + 10)
        ]
        NSLayoutConstraint.activate(bottomEmptyViewConstraints)
        
        topEmptyView.translatesAutoresizingMaskIntoConstraints = false
        let topEmptyViewConstraints = [
            topEmptyView.heightAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(topEmptyViewConstraints)
    }
    
    private func showOverlay(){
        UIView.animate(withDuration: 0.25) {
            self.navigationView.transform = CGAffineTransform(translationX: 1, y: 0)
            self.labelsMainView.transform = CGAffineTransform.identity
        }
    }
    
    private func hideOverlay(){
        UIView.animate(withDuration: 0.25) {
            self.navigationView.transform = CGAffineTransform(translationX: 1, y: -self.safeAreatopHeight - 50)
            self.labelsMainView.transform = CGAffineTransform(translationX: 1, y: self.screenHeight / 2)
        }
    }
    
    @objc private func imageTapped(){
        isOverlayHidden.toggle()
        if isOverlayHidden{
            hideOverlay()
        } else{
            showOverlay()
        }
    }
}
