//
//  RepoTableViewCell.swift
//  GithubTopSwift
//
//  Created by Decio Lucas Montanhani - DMN on 10/05/19.
//  Copyright © 2019 Décio Montanhani. All rights reserved.
//

import UIKit
import Kingfisher

class RepoTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var repoNameLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var starsLabel: UILabel!
    @IBOutlet private weak var userAvatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(model: Repository) {
        repoNameLabel.text = model.repoName
        usernameLabel.text = model.owner?.ownerName
        let stars = model.stars ?? 0
        starsLabel.text = "\(stars)"
        
        userAvatarImage.kf.indicatorType = IndicatorType.activity
        if let avatarUrl = model.owner?.avatarUrl {
            userAvatarImage.kf.setImage(with: URL(string: avatarUrl))
        } else {
            userAvatarImage.image = UIImage(named: "github")
        }
    }
    
}
