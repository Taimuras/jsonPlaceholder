//
//  PhotosCollectionViewCell.swift
//  JsonPlaceholder
//
//  Created by Timur on 12/10/22.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    static let idintifier = "PhotosCollectionViewCell"
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .userTVCellBG
        return view
    }()
    
    private lazy var mainImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    private lazy var titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.75)
        return view
    }()
    
    private lazy var titleLabel = BaseLabel(type: .smallTitle)
    
    var viewModel: PhotosCollectionViewCellViewModelProtocol = PhotosCollectionViewCellViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupValues()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        contentView.addSubviews(mainView)
        mainView.addSubviews(mainImageView, titleView)
        titleView.addSubview(titleLabel)
    }
    
    private func setupConstraints(){
        mainView.frame = contentView.bounds
        mainImageView.frame = mainView.bounds
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        let titleViewConstraints = [
            titleView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0),
            titleView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0),
            titleView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0),
            titleView.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(titleViewConstraints)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 6),
            titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -6),
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 6),
            titleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -6),
        ]
        NSLayoutConstraint.activate(titleLabelConstraints)
    }
    
    private func setupValues(){
        viewModel.imageData = {[weak self] (imageData) in
            DispatchQueue.main.async {
                self?.mainImageView.image = UIImage(data: imageData)
            }
        }
    }
    
    func config(with photoModel: PhotoModel, index: Int){
        viewModel.getImage(photoModel: photoModel)
        
        if let title = photoModel.title{
            titleLabel.text = title.capitalized
            titleView.backgroundColor = .white.withAlphaComponent(0.75)
        } else{
            titleLabel.text = ""
            titleView.backgroundColor = .clear
        }
    }
}




