//
//  PhotosViewModel.swift
//  JsonPlaceholder
//
//  Created by Timur on 12/10/22.
//

import UIKit

protocol PhotosViewModelProtocol: BaseViewModelProtocol, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    var user: UserModel? { get set }
    var album: AlbumModel? { get set }
    var isLoadingComp: BoolCompletion? { get set }
    
    func reloadData()
    func register(collectionView: UICollectionView)
    func getAllImages()
}

class PhotosViewModel: NSObject, PhotosViewModelProtocol{
    let networkManager: NetworkManagerProtocol
    init(networkManager: NetworkManagerProtocol = NetworkManager()){
        self.networkManager = networkManager
    }
    
    weak var view: BaseViewControllerProtocol?
    var user: UserModel?
    var album: AlbumModel?
    private var photos: [PhotoModel] = [PhotoModel]()
    var isLoadingComp: BoolCompletion?
    var isLoading: Bool = true
    
    private var collectionView: UICollectionView?
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 12
        layout.invalidateLayout()
        return layout
    }()
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    func register(collectionView: UICollectionView) {
        collectionView.collectionViewLayout = collectionViewLayout
        self.collectionView = collectionView
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.idintifier)
    }
    
    func getAllImages() {
        guard let albumId = album?.id else {return}
        loadingState(is: true)
        reloadData()
        networkManager.getAllImages(id: albumId) { [weak self] (photos) in
            self?.photos = photos
            self?.loadingState(is: false)
            self?.reloadData()
        } onError: { [weak self] (error) in
            self?.photos = []
            self?.loadingState(is: false)
            self?.reloadData()
            self?.view?.showError(error: error)
        }
    }
    
    private func loadingState(is loading: Bool){
        isLoading = loading
        isLoadingComp?(loading)
        if loading{
            photos.removeAll()
            reloadData()
        }
    }
}

//MARK: Collection View
extension PhotosViewModel{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isLoading ? 0 : photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.idintifier, for: indexPath) as! PhotosCollectionViewCell
        
        if !isLoading{
            let photo = photos[indexPath.row]
            cell.config(with: photo, index: indexPath.row)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let user = user,
              let album = album
        else {return}
        let photo = photos[indexPath.row]
        
        let vc = SinglePhotoViewController(user: user, album: album, photo: photo)
        self.view?.push(vc: vc)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: (collectionView.frame.width - 48 ) / 3, height: (collectionView.frame.width - 48 ) / 3)
    }
}
