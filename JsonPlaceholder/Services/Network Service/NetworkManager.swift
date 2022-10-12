//
//  NetworkManager.swift
//  JsonPlaceholder
//
//  Created by Timur on 11/10/22.
//

import Foundation

protocol NetworkManagerProtocol{
    func getAllUsers(onSuccess: @escaping ([UserModel]) -> Void, onError: @escaping (APIError) -> Void)
    func getAllAlbums(id: Int, onSuccess: @escaping ([AlbumModel]) -> Void, onError: @escaping (APIError) -> Void)
    func getAllImages(id: Int, onSuccess: @escaping ([PhotoModel]) -> Void, onError: @escaping (APIError) -> Void)
    func getSingleImage(urlString: String, onSuccess: @escaping (Data) -> Void, onError: @escaping (APIError) -> Void)
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
    
    func getAllAlbums(id: Int, onSuccess: @escaping ([AlbumModel]) -> Void, onError: @escaping (APIError) -> Void){
        provider.load(service: .getAllAlbums(id: id), decodeType: [AlbumModel].self) { (result) in
            switch result{
            case .success(let albums):
                onSuccess(albums)
            case .empty:
                onError(.emptyData)
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    func getAllImages(id: Int, onSuccess: @escaping ([PhotoModel]) -> Void, onError: @escaping (APIError) -> Void){
        provider.load(service: .getAllImages(id: id), decodeType: [PhotoModel].self) { (result) in
            switch result{
            case .success(let photos):
                onSuccess(photos)
            case .empty:
                onError(.emptyData)
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    func getSingleImage(urlString: String, onSuccess: @escaping (Data) -> Void, onError: @escaping (APIError) -> Void){
        provider.loadImage(urlString: urlString) { (result) in
            switch result{
            case .success(let data):
                onSuccess(data)
            case .empty:
                onError(.emptyData)
            case .failure(let error):
                onError(error)
            }
        }
    }
}
