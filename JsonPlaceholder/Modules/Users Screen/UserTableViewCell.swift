//
//  UserTableViewCell.swift
//  JsonPlaceholder
//
//  Created by Timur on 11/10/22.
//

import UIKit

class UserTableViewCell: UITableViewCell{
    static let idintifier = "UserTableViewCell"
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .userTVCellBG
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var iconsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 4
        return stack
    }()
    
    private lazy var userImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = .personIconImage
        return iv
    }()
    
    private lazy var cityImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = .addressIconImage
        return iv
    }()
    
    private lazy var emailImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = .emailIconImage
        return iv
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 4
        return stack
    }()
    
    private lazy var userNameLabel = BaseLabel(type: .userName)
    
    private lazy var addressLabel = BaseLabel(type: .address)
    
    private lazy var emailLabel = BaseLabel(type: .email)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        mainSetup()
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func mainSetup(){
        contentView.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupView() {
        mainView.addSubviews(
            iconsStackView,
            labelsStackView
        )
    }
    
    private func setupConstraints() {
        iconStackViewSetup()
        lablesStackViewSetup()
    }
    
    private func iconStackViewSetup(){
        iconsStackView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            iconsStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            iconsStackView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 6),
            iconsStackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -6),
            iconsStackView.widthAnchor.constraint(equalToConstant: 20),
            emailImageView.heightAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(constraints)
        
        [userImageView, cityImageView, emailImageView].forEach{iconsStackView.addArrangedSubview($0)}
    }
    
    private func lablesStackViewSetup(){
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            labelsStackView.leadingAnchor.constraint(equalTo: iconsStackView.trailingAnchor, constant: 10),
            labelsStackView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 6),
            labelsStackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -6),
            labelsStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            emailLabel.heightAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(constraints)
        
        [userNameLabel, addressLabel, emailLabel].forEach{labelsStackView.addArrangedSubview($0)}
    }
    
    func config(with user: UserModel, index: Int){
        if let name = user.name{
            userNameLabel.text = name
        } else{
            userNameLabel.text = "No Name"
        }
        
        if let cityName = user.address{
            addressLabel.text = cityName.city ?? ""
        }else{
            addressLabel.text = ""
        }
        
        if let email = user.email{
            emailLabel.text = email
        } else{
            emailLabel.text = ""
        }
    }
}



