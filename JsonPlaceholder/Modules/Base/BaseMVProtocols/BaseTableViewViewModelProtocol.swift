//
//  BaseTableViewViewModelProtocol.swift
//  JsonPlaceholder
//
//  Created by Timur on 12/10/22.
//

import UIKit

protocol BaseTableViewViewModelProtocol: BaseViewModelProtocol, UITableViewDataSource, UITableViewDelegate{
    var isLoadingComp: BoolCompletion? { get set }
    func getData()
    func registerTableView(_ tableView: UITableView)
    func reloadData()
}
