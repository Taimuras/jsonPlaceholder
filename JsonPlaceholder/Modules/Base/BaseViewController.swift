//
//  BaseViewController.swift
//  JsonPlaceholder
//
//  Created by Timur on 11/10/22.
//

import UIKit

class BaseViewController: UIViewController{
    private lazy var alertView = AlertView(on: self)
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.startAnimating()
        ai.color = .navigationBG
        return ai
    }()
    
    lazy var navigationView = NavigationView(type: navigationType) { [ weak self ] in
        self?.popBackViewController()
    }
    
    private var navigationType: NavigationType
    
    init(navigationType: NavigationType){
        self.navigationType = navigationType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        navigationViewSetup()
        
        setupViews()
        setupConstraints()
        setupValues()
        setupNavigationItem()
        themeView()
    }
    
    func setupViews() {}
    
    func setupConstraints() {}
    
    func setupValues(){
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .mainBG
    }
    
    func setupNavigationItem() {}
    
    func themeView() {}
}

//MARK: NavigationView Setup
extension BaseViewController{
    private func navigationViewSetup(){
        view.addSubview(navigationView)
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            navigationView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            navigationView.heightAnchor.constraint(equalToConstant: safeAreatopHeight + 50)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

//MARK: Activity Indicator Setup
extension BaseViewController{
    private func addActivityIndicator(){
        if !view.subviews.contains(activityIndicator){
            view.addSubview(activityIndicator)
            activityIndicator.frame = view.bounds
        }
    }
    
    private func removeActivityIndicator(){
        if view.subviews.contains(activityIndicator){
            activityIndicator.removeFromSuperview()
        }
    }
}

extension BaseViewController: BaseViewControllerProtocol{
    var currentView: UIView {
        view
    }
    
    func showError(error: APIError) {
        alertView.showAlert(with: error.title, message: error.description)
    }
    
    func present(vc: UIViewController) {
        self.present(vc, animated: true)
    }
    
    func push(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentOverFullScreen(vc: UIViewController) {
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
    }
    
    func popToViewController(vc: UIViewController) {
        let vcs = navigationController?.viewControllers ?? []
        for i in 0 ..< vcs.count{
            if type(of: vcs[i]) == type(of: vc){
                navigationController?.popToViewController(vcs[i], animated: true)
            }
        }
    }
    
    func popBackViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    func popToRootViewController() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func startLoading() {
        addActivityIndicator()
    }
    
    func stopLoading() {
        removeActivityIndicator()
    }
}
