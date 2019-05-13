//
//  RepositoryResponse.swift
//  GithubTopSwift
//
//  Created by Decio Montanhani on 12/05/19.
//  Copyright © 2019 Décio Montanhani. All rights reserved.
//

import Foundation

struct RepositoryResponse : Codable {
    let items : [Repository]?
}
