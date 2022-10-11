//
//  NetworkManager.swift
//  JsonPlaceholder
//
//  Created by Timur on 11/10/22.
//

import Foundation

protocol NetworkManagerProtocol{
    func getAllUsers(onSuccess: @escaping ([UserModel]) -> Void, onError: @escaping (APIError) -> Void)
}


class NetworkManager: NetworkManagerProtocol{
    private let provider = ServiceProvider<NetworkService>()
    
    func getAllUsers(onSuccess: @escaping ([UserModel]) -> Void, onError: @escaping (APIError) -> Void){
        provider.load(service: .getAllUsers, decodeType: [UserModel].self) { (result) in
            switch result{
            case .success(let users):
                onSuccess(users)
            case .empty:
                onError(.emptyData)
            case .failure(let error):
                onError(error)
            }
        }
    }
}
