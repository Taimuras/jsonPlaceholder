//
//  DataStoreProtocol.swift
//  JsonPlaceholder
//
//  Created by Timur on 12/10/22.
//

import Foundation


protocol DataStore{
    func setCurrentUser(_ userName: String)
    func getCurrentUser() -> String?
    
    func removeAll()
}

