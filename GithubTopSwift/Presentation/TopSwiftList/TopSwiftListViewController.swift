//
//  TopSwiftListViewController.swift
//  GithubTopSwift
//
//  Created by Decio Montanhani on 06/05/19.
//  Copyright © 2019 Décio Montanhani. All rights reserved.
//

import UIKit

class TopSwiftListViewController: UIViewController {

    // MARK: - Properties
    
    // MARK: - Initializers
    static func instantiate() -> TopSwiftListViewController {
        let viewController = TopSwiftListViewController(nibName: String(describing: TopSwiftListViewController.self), bundle: nil)
        viewController.title = "Swift Top+"
        return viewController
    }
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
