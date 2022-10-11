//
//  User.swift
//  JsonPlaceholder
//
//  Created by Timur on 11/10/22.
//

import Foundation


struct UserModel: Codable{
    var id: Int?
    var name: String?
    var email: String?
    var address: City?
    
    enum CodingKeys: String, CodingKey{
        case id
        case name
        case email
        case address
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        address = try values.decodeIfPresent(City.self, forKey: .address)
    }
}

struct City: Codable{
    var city: String?
    
    enum CodingKeys: String, CodingKey{
        case city
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city = try values.decodeIfPresent(String.self, forKey: .city)
    }
}

