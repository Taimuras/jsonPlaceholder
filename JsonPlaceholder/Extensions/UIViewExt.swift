//
//  UIViewExt.swift
//  JsonPlaceholder
//
//  Created by Timur on 11/10/22.
//

import UIKit


extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {addSubview($0)}
    }
}
