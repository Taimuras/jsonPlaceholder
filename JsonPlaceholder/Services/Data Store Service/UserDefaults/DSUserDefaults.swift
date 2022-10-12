//
//  DSUserDefaults.swift
//  JsonPlaceholder
//
//  Created by Timur on 12/10/22.
//

import Foundation

class DSUserDefaults: DataStore{
    static let shared = DSUserDefaults()
    
    private let userDefaults = UserDefaults.standard
    
    private let pUserName = "pUserName"
    
    func setCurrentUser(_ userName: String) {
        userDefaults.set(userName, forKey: pUserName)
    }
    
    func getCurrentUser() -> String? {
        return userDefaults.string(forKey: pUserName)
    }
    
    func removeAll() {
        userDefaults.removeObject(forKey: pUserName)
    }
}
