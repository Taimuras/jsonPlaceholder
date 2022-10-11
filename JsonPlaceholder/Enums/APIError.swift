//
//  APIError.swift
//  JsonPlaceholder
//
//  Created by Timur on 11/10/22.
//

import Foundation

enum APIError{
    case custom(message: String)
    case unAuthorized
    case notFound
    case serverSideProblems
    case oopsSomethingWentWrong
    case decodingProblem
    case emptyData
}

extension APIError{
    var title: String{
        "Error found"
    }
    
    var description: String{
        switch self {
        case .custom(let message): return message.capitalized
        case .unAuthorized: return "You must to authorize"
        case .notFound: return "404! Not Found"
        case .serverSideProblems: return "Server is under maintenance. Please try again later"
        case .oopsSomethingWentWrong: return "Oops. Something went wrong..."
        case .decodingProblem: return "Decoded wrong"
        case .emptyData: return "Empty Data"
        }
    }
}
