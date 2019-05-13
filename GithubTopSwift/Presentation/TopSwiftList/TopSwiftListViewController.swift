//
//  TopSwiftListViewController.swift
//  GithubTopSwift
//
//  Created by Decio Montanhani on 06/05/19.
//  Copyright © 2019 Décio Montanhani. All rights reserved.
//

// MARK: - Imports
import UIKit
import RxSwift
import RxCocoa

class TopSwiftListViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    // MARK: - Lets
    private let disposeBag = DisposeBag()
    
    // MARK: - Vars
    private var waitForLoad: Bool = true
    
    // MARK: - Properties
    var viewModel: TopSwiftListViewModelProtocol?
    
    // MARK: - Initializers
    static func instantiate(viewModel: TopSwiftListViewModelProtocol = TopSwiftListViewModel()) -> TopSwiftListViewController {
        let viewController = TopSwiftListViewController(nibName: String(describing: TopSwiftListViewController.self), bundle: nil)
        viewController.title = "Swift Top+"
        viewController.viewModel = viewModel
        return viewController
    }
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        bindState()
        viewModel?.fetchRepositories(isFirstTime: true)
    }
    
    func setupView() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadFirstPage), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
        
        searchBar.rx.text.orEmpty.asObservable().map { $0 }.bind(onNext: { query in
            self.waitForLoad = query.isEmpty ? false : true
        }).disposed(by: disposeBag)

        self.tableView.register(cellType: RepoTableViewCell.self)

        let searchBarCollection = searchBar.rx.text.orEmpty.asObservable().map { $0.lowercased() }
        
        let observableRepo = self.viewModel?.repositories ?? Observable<[Repository]>.just([])
        
        let repos = Observable<[Repository]>.combineLatest(searchBarCollection, observableRepo) {
            text, repos in
            let content = text.isEmpty ? repos : repos.filter { $0.repoName?.lowercased().contains(text) ?? false }
            return content
        }
        
        repos.bind(to: self.tableView.rx.items(cellIdentifier: String(describing: RepoTableViewCell.self), cellType: RepoTableViewCell.self)) { row, element, cell in
            cell.setup(model: element)
            }.disposed(by: disposeBag)
        
        self.tableView.rx.didScroll.map { $0 }.bind {
            let offset: CGFloat = 30
            let bottomEdge = self.tableView.contentOffset.y + self.tableView.frame.size.height
            if bottomEdge + offset >= self.tableView.contentSize.height {
                if !self.waitForLoad {
                    self.loadRepositories()
                }
            }
            }.disposed(by: disposeBag)
        
        self.tableView.rx.itemSelected.map { $0 }.bind { indexPath in
            self.tableView.deselectRow(at: indexPath, animated: true)
            }.disposed(by: disposeBag)
    }
    
    @objc
    func reloadFirstPage() {
        waitForLoad = true
        viewModel?.fetchRepositories(isFirstTime: true)
    }
    
    func loadRepositories() {
        waitForLoad = true
        viewModel?.fetchRepositories(isFirstTime: false)
    }

    func bindState() {
        viewModel?.state.bind(onNext: { [weak self] state in
            switch state {
            case .success:
                self?.waitForLoad = false
                self?.tableView.refreshControl?.endRefreshing()
            case .error:
                self?.waitForLoad = false
                self?.tableView.refreshControl?.endRefreshing()
                Alert.shared.showMessage(message: "Erro ao fazer a requisição. Tente novamente mais tarde.", mode: .error)
            case .none:
                print("do nothing")
            }
        }).disposed(by: disposeBag)
    }
}
