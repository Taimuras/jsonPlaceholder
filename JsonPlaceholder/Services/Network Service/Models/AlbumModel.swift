//
//  AlbumModel.swift
//  JsonPlaceholder
//
//  Created by Timur on 12/10/22.
//

import Foundation


struct AlbumModel: Codable{
    var id: Int?
    var userId: Int?
    var title: String?
    
    enum CodingKeys: String, CodingKey{
        case id
        case userId
        case title
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
}
