//
//  NetworkService.swift
//  JsonPlaceholder
//
//  Created by Timur on 11/10/22.
//

import Foundation

enum NetworkService{
    case getAllUsers
    case getAllAlbums(id: Int)
    case getAllImages(id: Int)
    case getSingleImage(urlString: String)
}

extension NetworkService: Service{
    var baseURL: String {
        switch self{
        case .getSingleImage(let urlString): return "\(urlString)"
        default: return "https://jsonplaceholder.typicode.com"
        }
    }
    
    var path: String {
        switch self {
        case .getAllUsers: return "/users"
        case .getAllAlbums(let id): return "/users/\(id)/albums"
        case .getAllImages(let id): return "/albums/\(id)/photos"
        case .getSingleImage: return ""
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
