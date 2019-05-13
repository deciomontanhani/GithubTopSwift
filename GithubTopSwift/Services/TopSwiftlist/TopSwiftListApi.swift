//
//  TopSwiftListApi.swift
//  GithubTopSwift
//
//  Created by Decio Montanhani on 12/05/19.
//  Copyright © 2019 Décio Montanhani. All rights reserved.
//

import Moya

enum TopSwiftListApi {
    case popular(page: Int)
}

extension TopSwiftListApi: TargetType {
    var baseURL: URL {
        return URL(string: K.ApiServer.BaseURL)!
    }
    
    var path: String {
        switch self {
        case .popular:
            return "/search/repositories"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        fatalError()
    }
    
    var task: Task {
        switch self {
        case .popular(let page):
            return .requestParameters(parameters: ["q": "language:swift","sort": "stars", "page" : page],
                                  encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }

}
