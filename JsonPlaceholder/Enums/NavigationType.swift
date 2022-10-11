//
//  NavigationType.swift
//  JsonPlaceholder
//
//  Created by Timur on 11/10/22.
//

import Foundation

enum NavigationType{
    case usersScreen
}

extension NavigationType{
    var title: String{
        switch self {
        case .usersScreen:
            return "Users Screen"
        }
    }
}
