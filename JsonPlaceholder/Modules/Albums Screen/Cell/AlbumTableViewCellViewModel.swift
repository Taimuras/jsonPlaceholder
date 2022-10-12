//
//  AlbumTableViewCellViewModel.swift
//  JsonPlaceholder
//
//  Created by Timur on 12/10/22.
//

import Foundation

protocol AlbumTableViewCellViewModelProtocol{
    var images: [PhotoModel]? { get set }
    var imageData: ((Data) -> Void)? { get set }
    func getAllImages(id: Int)
}

class AlbumTableViewCellViewModel: AlbumTableViewCellViewModelProtocol{
    let networkManager: NetworkManagerProtocol
    init(networkManager: NetworkManagerProtocol = NetworkManager()){
        self.networkManager = networkManager
    }
    
    var images: [PhotoModel]?
    var imageData: ((Data) -> Void)?
    
    func getAllImages(id: Int){
        networkManager.getAllImages(id: id) { [weak self] (photos) in
            self?.images = photos
            if !photos.isEmpty{
                self?.getRandomImage(photoModel: photos.randomElement()!)
            }
        } onError: { (error) in
            print(error)
        }
    }
    
    private func getRandomImage(photoModel: PhotoModel){
        guard let urlString = photoModel.thumbnailUrl else {return}
        networkManager.getSingleImage(urlString: urlString) { [weak self] (data) in
            self?.imageData?(data)
        } onError: { (error) in
            print(error.description)
        }
    }
}
