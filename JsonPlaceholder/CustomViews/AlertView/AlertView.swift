//
//  AlertView.swift
//  JsonPlaceholder
//
//  Created by Timur on 11/10/22.
//

import UIKit

class AlertView: UIView{
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private lazy var alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private lazy var mainButton: UIButton = {
        let button = UIButton()
        button.setTitle("Dismiss", for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.backgroundColor = .navigationBG
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        return button
    }()
    
    let backgroundAlphaTo: CGFloat = 0.6
    
    var targetView: UIView
    
    init(on viewController: UIViewController){
        self.targetView = viewController.view
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        targetView.addSubviews(backgroundView, alertView)
        alertView.addSubviews(titleLabel, descriptionLabel, mainButton)
    }
    
    private func setupConstraints(){
        backgroundView.frame = targetView.bounds
        alertView.frame = CGRect(x: 20, y: -300, width: screenWidth - 40, height: 300)
        
        titleLabel.center = alertView.center
        titleLabel.frame = CGRect(x: 12, y: 20, width: alertView.frame.size.width - 24, height: 22)
        descriptionLabel.frame = CGRect(x: 12, y: 50, width: alertView.frame.size.width - 24, height: 166)
        mainButton.frame = CGRect(x: 12, y: alertView.frame.size.height - 62, width: alertView.frame.size.width - 24, height: 50)
    }
    
    @objc private func dismiss(){
        dismissAlert()
    }
    
    func showAlert(with title: String, message: String){
        titleLabel.text = title
        descriptionLabel.text = message
        animateIn()
    }
    
    func dismissAlert(){
        animateOut()
    }
}

//MARK: Animations
extension AlertView{
    private func animateIn(){
        UIView.animate(withDuration: 0.25, animations: {
            self.backgroundView.alpha = self.backgroundAlphaTo
        }, completion: { (done) in
            if done{
                UIView.animate(withDuration: 0.25) {
                    self.alertView.center = self.targetView.center
                }
            }
        })
    }
    
    private func animateOut(){
        UIView.animate(withDuration: 0.25, animations: {
            self.alertView.frame = CGRect(x: 20, y: self.screenHeight + 300, width: self.screenWidth - 40, height: 300)
        }, completion: { (done) in
            if done{
                UIView.animate(withDuration: 0.25) {
                    self.backgroundView.alpha = 0
                }
            }
        })
    }
}
