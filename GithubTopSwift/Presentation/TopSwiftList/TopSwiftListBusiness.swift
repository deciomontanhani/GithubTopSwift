//
//  TopSwiftListBusiness.swift
//  GithubTopSwift
//
//  Created by Decio Montanhani on 12/05/19.
//  Copyright © 2019 Décio Montanhani. All rights reserved.
//

// MARK: - Imports
import UIKit
import RxSwift

// MARK: Protocols
protocol TopSwiftListBusinessProtocol: class {
    func fetchRepositories(page: Int, completion: @escaping (Result<RepositoryResponse, ApiError>) -> Void)
}

// MARK: - Class/Objects
class TopSwiftListBusiness: TopSwiftListBusinessProtocol {
    
    // MARK: - Lets
    private let disposeBag = DisposeBag()
    
    // MARK: - Public Methods
    func fetchRepositories(page: Int, completion: @escaping (Result<RepositoryResponse, ApiError>) -> Void) {
        TopSwiftListService.shared.popular(page: page).do(onSuccess: { success in
            completion(success)
        }, onError: { error in
            completion(.failure(ApiError.standard(error: error)))
        }, onSubscribe: {
            print("onSubscribe")
        }).subscribe().disposed(by: disposeBag)
    }
}
