//
//  NetworkService.swift
//  JsonPlaceholder
//
//  Created by Timur on 11/10/22.
//

import Foundation

enum NetworkService{
    case getAllUsers
}

extension NetworkService: Service{
    var baseURL: String {
        return "https://jsonplaceholder.typicode.com"
    }
    
    var path: String {
        switch self {
        case .getAllUsers: return "/users"
        }
    }
    
    var queryParameters: [String : String]? {
        switch self {
        default: return nil
        }
    }
    
    var method: ServiceMethod {
        switch self {
        default: return .get
        }
    }
    
    var bodyParameters: Data? {
        switch self {
        default: return nil
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default: return nil
        }
    }
}
