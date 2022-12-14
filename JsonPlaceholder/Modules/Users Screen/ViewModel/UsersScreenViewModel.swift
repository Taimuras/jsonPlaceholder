//
//  UsersScreenViewModel.swift
//  JsonPlaceholder
//
//  Created by Timur on 11/10/22.
//

import UIKit

class UsersScreenViewModel: NSObject, BaseTableViewViewModelProtocol{
    var networkManager: NetworkManagerProtocol
    init(networkManager: NetworkManagerProtocol = NetworkManager()){
        self.networkManager = networkManager
    }
    weak var view: BaseViewControllerProtocol?
    private var tableView: UITableView?
    var users: [UserModel] = [UserModel]()
    var isLoadingComp: BoolCompletion?
    var isLoading: Bool = true
    
    func getData(){
        loadingState(is: true)
        networkManager.getAllUsers { [weak self] (users) in
            self?.users = users
            self?.loadingState(is: false)
            self?.reloadData()
        } onError: { [weak self] (error) in
            self?.users = []
            self?.loadingState(is: false)
            self?.reloadData()
            self?.view?.showError(error: error)
        }
    }
    
    func registerTableView(_ tableView: UITableView){
        self.tableView = tableView
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.idintifier)
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
            users.removeAll()
            reloadData()
        }
    }
}

extension UsersScreenViewModel: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isLoading ? 0 : users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.idintifier, for: indexPath) as! UserTableViewCell
        
        if !isLoading{
            let user = users[indexPath.row]
            cell.config(with: user, index: indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if !isLoading{
            let user = users[indexPath.row]
            
            if let userName = user.name{
                DSGenerator.userDefaultsInstance.setCurrentUser(userName)
            }
            
            let vc = AlbumsViewController(user: user)
            self.view?.push(vc: vc)
        }
    }
}
