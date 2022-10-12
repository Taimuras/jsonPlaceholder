//
//  SinglePhotoViewModel.swift
//  JsonPlaceholder
//
//  Created by Timur on 12/10/22.
//

import Foundation


protocol SinglePhotoViewModelProtocol: BaseViewModelProtocol{
    func getSingleImage(urlString: String, completion: @escaping (Data) -> Void)
}

class SinglePhotoViewModel: SinglePhotoViewModelProtocol{
    var view: BaseViewControllerProtocol?
    
    let networkManager: NetworkManagerProtocol
    init(networkManager: NetworkManagerProtocol = NetworkManager()){
        self.networkManager = networkManager
    }
    
    func getSingleImage(urlString: String, completion: @escaping (Data) -> Void){
        networkManager.getSingleImage(urlString: urlString) { (imageData) in
            completion(imageData)
        } onError: { [weak self] (error) in
            self?.view?.showError(error: error)
        }
    }
}
