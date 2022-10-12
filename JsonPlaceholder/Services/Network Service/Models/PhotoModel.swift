//
//  PhotoModel.swift
//  JsonPlaceholder
//
//  Created by Timur on 12/10/22.
//

import Foundation

struct PhotoModel: Codable{
    var id: Int?
    var albumId: Int?
    var title: String?
    var url: String?
    var thumbnailUrl: String?
    
    enum CodingKeys: String, CodingKey{
        case id
        case albumId
        case title
        case url
        case thumbnailUrl
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        albumId = try values.decodeIfPresent(Int.self, forKey: .albumId)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        thumbnailUrl = try values.decodeIfPresent(String.self, forKey: .thumbnailUrl)
    }
}
