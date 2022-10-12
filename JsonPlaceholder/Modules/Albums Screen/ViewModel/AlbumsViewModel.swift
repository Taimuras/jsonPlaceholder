//
//  AlbumsViewModel.swift
//  JsonPlaceholder
//
//  Created by Timur on 12/10/22.
//

import UIKit

protocol AlbumsViewModelProtocol: BaseTableViewViewModelProtocol{
    var user: UserModel? { get set }
}

class AlbumsViewModel: NSObject, AlbumsViewModelProtocol{
    var networkManager: NetworkManagerProtocol
    init(networkManager: NetworkManagerProtocol = NetworkManager()){
        self.networkManager = networkManager
    }
    
    var user: UserModel?
    weak var view: BaseViewControllerProtocol?
    private var tableView: UITableView?
    var albums: [AlbumModel] = [AlbumModel]()
    var isLoadingComp: BoolCompletion?
    var isLoading: Bool = true
    
    func getData(){
        loadingState(is: true)
        reloadData()
        guard let userID = user?.id else {return}
        networkManager.getAllAlbums(id: userID) { [weak self] (albums) in
            self?.albums = albums
            self?.loadingState(is: false)
            self?.reloadData()
        } onError: { [weak self] (error) in
            self?.albums = []
            self?.loadingState(is: false)
            self?.reloadData()
            self?.view?.showError(error: error)
        }
    }
    
    func registerTableView(_ tableView: UITableView){
        self.tableView = tableView
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: AlbumTableViewCell.idintifier)
    }
    
    func reloadData(){
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
    
    private func loadingState(is loading: Bool){
        isLoading = loading
        isLoadingComp?(loading)
        if loading{
            albums.removeAll()
            reloadData()
        }
    }
}

extension AlbumsViewModel: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isLoading ? 0 : albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.idintifier, for: indexPath) as! AlbumTableViewCell
        
        if !isLoading{
            let album = albums[indexPath.row]
            cell.config(with: album, index: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let user = user else {return}
        let album = albums[indexPath.row]
        let vc = PhotosViewController(user: user, album: album)
        self.view?.push(vc: vc)
    }
}

