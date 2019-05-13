//
//  Repository.swift
//  GithubTopSwift
//
//  Created by Decio Montanhani on 12/05/19.
//  Copyright © 2019 Décio Montanhani. All rights reserved.
//

import Foundation

struct Repository: Codable {
    let repoName: String?
    let stars: Int?
    let owner: RepositoryOwner?
    
    enum CodingKeys: String, CodingKey {
        case repoName = "name"
        case stars = "stargazers_count"
        case owner = "owner"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        repoName = try values.decodeIfPresent(String.self, forKey: .repoName)
        stars = try values.decodeIfPresent(Int.self, forKey: .stars)
        owner = try values.decodeIfPresent(RepositoryOwner.self, forKey: .owner)
    }
}
