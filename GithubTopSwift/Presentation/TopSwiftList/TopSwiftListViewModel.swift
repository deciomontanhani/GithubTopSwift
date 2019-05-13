//
//  TopSwiftListViewModel.swift
//  GithubTopSwift
//
//  Created by Decio Lucas Montanhani - DMN on 10/05/19.
//  Copyright © 2019 Décio Montanhani. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol TopSwiftListViewModelProtocol {
    
    var state: Observable<ViewStateEnum> { get }
    var business: TopSwiftListBusinessProtocol { get set}
    var repositories: Observable<[Repository]> { get }
    func fetchRepositories(isFirstTime: Bool)
}

enum ViewStateEnum {
    case success
    case error
    case none
}

class TopSwiftListViewModel: TopSwiftListViewModelProtocol {
    
     // MARK: - Vars
    var business: TopSwiftListBusinessProtocol
    var page: Int = 1
    
    private var viewState: BehaviorRelay<ViewStateEnum> = BehaviorRelay<ViewStateEnum>(value: .none)
    
    var state: Observable<ViewStateEnum> {
        return viewState.asObservable()
    }
    
    var repositories: Observable<[Repository]> {
        return repositoriesResponse.asObservable()
    }
    private var repositoriesResponse: BehaviorRelay<[Repository]> = BehaviorRelay(value: [])
    
    // MARK: - Initializers
    init(business: TopSwiftListBusinessProtocol = TopSwiftListBusiness()) {
        self.business = business
    }
    
    
    // MARK: - Public Methods
    func fetchRepositories(isFirstTime: Bool = false) {
        if isFirstTime {
            page = 1
        } else {
            page += 1
        }
        
        business.fetchRepositories(page: page) { result in
            switch result {
            case .success(let result):
                var repositories = self.repositoriesResponse.value
                guard let repos = result.items else { return }
                if isFirstTime {
                    self.repositoriesResponse.accept(repos)
                } else {
                    repositories.append(contentsOf: repos)
                    self.repositoriesResponse.accept(repositories)
                }
                self.viewState.accept(.success)
                
            case .failure(_):
                self.viewState.accept(.error)
            }
        }
    }
}
