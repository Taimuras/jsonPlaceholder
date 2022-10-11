//
//  NavigationView.swift
//  JsonPlaceholder
//
//  Created by Timur on 11/10/22.
//

import UIKit

class NavigationView: UIView{
    private lazy var titleLabel: UILabel = BaseLabel(type: .navigation)
    
    private lazy var backButton: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = .backButtonImage?.withTintColor(.black)
        iv.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    private var type: NavigationType
    private var action: EmptyCompletion
    
    init(type: NavigationType, with action: @escaping EmptyCompletion) {
        self.type = type
        self.action = action
        super.init(frame: .zero)
        setup()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        backgroundColor = .navigationBG
        titleLabel.text = type.title.capitalized
    }
    
    private func setupViews(){
        addSubview(titleLabel)
    }
    
    private func setupConstraints(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let titleConstraints = [
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13),
            titleLabel.heightAnchor.constraint(equalToConstant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
        NSLayoutConstraint.activate(titleConstraints)
        
        switch type {
        case .usersScreen:
            print("No need of back button")
        default:
            addBackButton()
        }
    }
    
    private func addBackButton(){
        addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        let backButtonConstraints = [
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24)
        ]
        NSLayoutConstraint.activate(backButtonConstraints)
    }
    
    @objc private func backButtonTapped(){
        action()
    }
}
