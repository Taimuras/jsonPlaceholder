//
//  UIViewControllerExt.swift
//  JsonPlaceholder
//
//  Created by Timur on 11/10/22.
//

import UIKit

//MARK: Keyboard dismissing
extension UIViewController{
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//MARK: AppDelegate variable
extension UIViewController{
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}
