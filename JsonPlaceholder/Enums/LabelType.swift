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
    case albumTitle
    case title
    case smallTitle
}

extension LabelType{
    var textAlignment: NSTextAlignment{
        switch self {
        case .navigation, .title, .smallTitle: return .center
        default: return .left
        }
    }
    
    var textColor: UIColor{
        switch self {
        case .address, .email, .title: return .descriptionTextColor
        default: return .mainTextColor
        }
    }
    
    var font: UIFont{
        switch self {
        case .navigation:return .systemFont(ofSize: 24, weight: .heavy)
        case .userName: return .systemFont(ofSize: 18, weight: .bold)
        case .address, .email: return .systemFont(ofSize: 16, weight: .regular)
        case .albumTitle: return .systemFont(ofSize: 20, weight: .semibold)
        case .title: return .systemFont(ofSize: 22, weight: .bold)
        case .smallTitle: return .systemFont(ofSize: 12, weight: .regular)
        }
    }
    
    var numberOfLines: Int{
        switch self {
        case .albumTitle, .smallTitle: return 0
        default: return 1
        }
    }
}
