//
//  PhotosCollectionViewCellViewModel.swift
//  JsonPlaceholder
//
//  Created by Timur on 12/10/22.
//

import Foundation

protocol PhotosCollectionViewCellViewModelProtocol{
    var imageData: ((Data) -> Void)? { get set }
    
    func getImage(photoModel: PhotoModel)
}

class PhotosCollectionViewCellViewModel: PhotosCollectionViewCellViewModelProtocol{
    let networkManager: NetworkManagerProtocol
    init(networkManager: NetworkManagerProtocol = NetworkManager()){
        self.networkManager = networkManager
    }

    var imageData: ((Data) -> Void)?
    
    func getImage(photoModel: PhotoModel){
        guard let urlString = photoModel.thumbnailUrl else {return}
        networkManager.getSingleImage(urlString: urlString) { [weak self] (data) in
            self?.imageData?(data)
        } onError: { (error) in
            print(error.description)
        }
    }
}

