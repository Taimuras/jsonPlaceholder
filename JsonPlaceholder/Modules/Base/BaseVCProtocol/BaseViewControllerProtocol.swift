//
//  BaseViewControllerProtocol.swift
//  JsonPlaceholder
//
//  Created by Timur on 11/10/22.
//

import UIKit


protocol BaseViewControllerProtocol: AnyObject {
    var currentView: UIView { get }
    
    func showError(error: APIError)
    func present(vc: UIViewController)
    func push(vc: UIViewController)
    func presentOverFullScreen(vc: UIViewController)
    func popToViewController(vc: UIViewController)
    func popBackViewController()
    func popToRootViewController()
    func startLoading()
    func stopLoading()
}
