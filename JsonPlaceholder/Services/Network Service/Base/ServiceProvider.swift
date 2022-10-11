//
//  ServiceProvider.swift
//  JsonPlaceholder
//
//  Created by Timur on 11/10/22.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(APIError)
    case empty
}

class ServiceProvider<T: Service> {
    var urlSession = URLSession.shared
    
    func loadData(service: T, completion: @escaping (Result<Data>) -> Void) {
        call(service.urlRequest, completion: completion)
    }
    
    func load<U>(service: T, decodeType: U.Type, completion: @escaping (Result<U>) -> Void) where U: Decodable {
        call(service.urlRequest) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let resp = try decoder.decode(decodeType, from: data)
                    completion(.success(resp))
                }
                catch {
                    completion(.failure(.decodingProblem))
                }
            case .failure(let error):
                completion(.failure(error))
            case .empty:
                completion(.empty)
            }
        }
    }
}

extension ServiceProvider {
    private func call(_ request: URLRequest, deliverQueue: DispatchQueue = DispatchQueue.main, completion: @escaping (Result<Data>) -> Void) {
        urlSession.dataTask(with: request) { (data, response, error) in
            
//            print("Response: \(response)")
            
            if error != nil {
                deliverQueue.async {
                    completion(.failure(.oopsSomethingWentWrong))
                }
            } else if let data = data {
                deliverQueue.async {
                    completion(.success(data))
                }
            } else {
                deliverQueue.async {
                    completion(.empty)
                }
            }
        }.resume()
    }
}

