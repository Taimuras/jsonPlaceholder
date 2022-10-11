//
//  AppSession.swift
//  JsonPlaceholder
//
//  Created by Timur on 11/10/22.
//

import UIKit

class AppSession{
    var window: UIWindow
    private var navController: UINavigationController?
    
    init(with window: UIWindow){
        self.window = window
    }
    
    func start(){
        mainApp()
        setupWindow()
    }
    
    private func mainApp(){
        navController = UINavigationController(rootViewController: UsersScreenViewController())
    }
    
    private func setupWindow(){
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
    
    private func animateTransition(){
        UIView.transition(with: window,
                          duration: 0.25,
                          options: [.transitionCrossDissolve],
                          animations: nil,
                          completion: nil)
    }
}
