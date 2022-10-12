//
//  AlbumTableViewCell.swift
//  JsonPlaceholder
//
//  Created by Timur on 12/10/22.
//

import UIKit

class AlbumTableViewCell: UITableViewCell{
    static let idintifier = "AlbumTableViewCell"
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .userTVCellBG
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var albumTitleLabel = BaseLabel(type: .albumTitle)
    
    private lazy var thumbnailImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = .placeHolderImage
        return iv
    }()
    
    var viewModel: AlbumTableViewCellViewModelProtocol = AlbumTableViewCellViewModel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        mainSetup()
        setupView()
        setupConstraints()
        setupValues()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func mainSetup(){
        contentView.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupView() {
        mainView.addSubviews(thumbnailImageView, albumTitleLabel)
    }
    
    private func setupConstraints() {
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        let thumbnailImageViewConstraints = [
            thumbnailImageView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            thumbnailImageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
            thumbnailImageView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(thumbnailImageViewConstraints)
        
        albumTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        let albumTitleLabelConstraints = [
            albumTitleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            albumTitleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 5),
            albumTitleLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -5),
            albumTitleLabel.trailingAnchor.constraint(equalTo: thumbnailImageView.leadingAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(albumTitleLabelConstraints)
    }
    
    private func setupValues(){
        viewModel.imageData = { [weak self] (imageData) in
            DispatchQueue.main.async {
                self?.thumbnailImageView.image = UIImage(data: imageData)
            }
        }
    }
    
    func config(with album: AlbumModel, index: Int){
        if let title = album.title{
            albumTitleLabel.text = title.capitalized
        } else{
            albumTitleLabel.text = ""
        }
        
        if let id = album.id{
            viewModel.getAllImages(id: id)
        } else{
            thumbnailImageView.image = .placeHolderImage
        }
    }
}




