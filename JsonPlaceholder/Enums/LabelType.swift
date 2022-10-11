//
//  LabelType.swift
//  JsonPlaceholder
//
//  Created by Timur on 11/10/22.
//

import UIKit


enum LabelType{
    case navigation
    case userName
    case address
    case email
}

extension LabelType{
    var textAlignment: NSTextAlignment{
        switch self {
        case .navigation: return .center
        default: return .left
        }
    }
    
    var textColor: UIColor{
        switch self {
        case .address, .email: return .descriptionTextColor
        default: return .mainTextColor
        }
    }
    
    var font: UIFont{
        switch self {
        case .navigation:return .systemFont(ofSize: 24, weight: .heavy)
        case .userName: return .systemFont(ofSize: 18, weight: .bold)
        case .address, .email: return .systemFont(ofSize: 16, weight: .regular)
        }
    }
}