//
//  Service.swift
//  JsonPlaceholder
//
//  Created by Timur on 11/10/22.
//

import Foundation

enum ServiceMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
    case put = "PUT"
}

protocol Service {
    var baseURL: String { get }
    var path: String { get }
    var queryParameters: [String: String]? { get }
    var method: ServiceMethod { get }
    var bodyParameters: Data? { get }
    var headers: [String: String]? { get }
}

extension Service {
    public var urlRequest: URLRequest {
        guard let url = self.url else {
            fatalError("URL could not be built")
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let bodyParams = bodyParameters{
            request.httpBody = bodyParams
        }
        
        if let headers = headers{
            for (key, value) in headers{
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
    
    private var url: URL? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = path
        
        if let parameters = queryParameters{
            urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        return urlComponents?.url
    }
}

