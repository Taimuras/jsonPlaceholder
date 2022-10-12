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
    case photoUserTitle
    case photoAlbumTitle
    case photoTitle
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
        case .photoAlbumTitle: return .mainTextColor.withAlphaComponent(0.7)
        case .photoTitle: return .mainTextColor.withAlphaComponent(0.5)
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
        case .photoUserTitle: return .systemFont(ofSize: 18, weight: .heavy)
        case .photoAlbumTitle: return .systemFont(ofSize: 16, weight: .bold)
        case .photoTitle: return .systemFont(ofSize: 14, weight: .semibold)
        }
    }
    
    var numberOfLines: Int{
        switch self {
        case .albumTitle, .smallTitle, .photoAlbumTitle, .photoTitle: return 0
        default: return 1
        }
    }
}
