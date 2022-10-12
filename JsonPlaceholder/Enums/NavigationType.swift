//
//  NavigationType.swift
//  JsonPlaceholder
//
//  Created by Timur on 11/10/22.
//

import Foundation

enum NavigationType{
    case usersScreen
    case albumsScreen
    case photosScreen
}

extension NavigationType{
    var title: String{
        switch self {
        case .usersScreen: return "Users Screen"
        case .albumsScreen: return "Albums Screen"
        case .photosScreen: return "Photos Screen"
        }
    }
}
