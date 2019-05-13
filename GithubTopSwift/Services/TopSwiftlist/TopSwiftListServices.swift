//
//  TopSwiftListService.swift
//  GithubTopSwift
//
//  Created by Decio Montanhani on 12/05/19.
//  Copyright © 2019 Décio Montanhani. All rights reserved.
//

// MARK: - Imports
import RxSwift
import RxCocoa
import Moya

// MARK: - Protocols
protocol TopSwiftListServiceProtocol: class {
    func popular(page: Int) -> Single<Result<RepositoryResponse, ApiError>>
}


class TopSwiftListService: TopSwiftListServiceProtocol {
    
    // MARK: - Vars
    var repos: Single<[Repository]> {
        return Single.create { single -> Disposable in
            let result = [Repository]()
            single(.success(result))
            return Disposables.create()
        }
    }
    
    // MARK: - Lets
    static let shared: TopSwiftListServiceProtocol = TopSwiftListService()
    private let apiClient: MoyaProvider<TopSwiftListApi>
    private let disposeBag = DisposeBag()
    
    // MARK: - Public Methods
    func popular(page: Int) -> Single<Result<RepositoryResponse, ApiError>> {
        return apiClient.rx.request(.popular(page: page))
            .map({ response -> Result<RepositoryResponse,ApiError> in
                return response.result(type: RepositoryResponse.self)
            })
    }
    
    // MARK: - Initializers
    init(_ provider: MoyaProvider<TopSwiftListApi>) {
        self.apiClient = provider
    }
    
    private convenience init() {
        self.init(MoyaProvider<TopSwiftListApi>())
    }
    
}
