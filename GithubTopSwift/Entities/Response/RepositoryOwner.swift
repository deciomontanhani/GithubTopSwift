//
//  RepositoryOwner.swift
//  GithubTopSwift
//
//  Created by Decio Montanhani on 12/05/19.
//  Copyright © 2019 Décio Montanhani. All rights reserved.
//

import Foundation

struct RepositoryOwner : Codable {
    
    let avatarUrl : String?
    let ownerName : String?
    
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case ownerName = "login"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        avatarUrl = try values.decodeIfPresent(String.self, forKey: .avatarUrl)
        ownerName = try values.decodeIfPresent(String.self, forKey: .ownerName)
    }
    
}
