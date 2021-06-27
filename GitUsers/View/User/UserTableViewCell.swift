//
//  UserTableViewCell.swift
//  GitUsers
//
//  Created by Jules Gilos on 6/27/21.
//

import UIKit
import Kingfisher

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    var viewModel: UserViewModel?
    
    enum Constants {
        static let identifier = "UserTableViewCell"
    }
    
    public func setup(with viewModel: UserViewModel) {
        self.viewModel = viewModel
        avatarImageView.kf.setImage(with: viewModel.avatar)
        nameLabel.text = viewModel.username
        urlLabel.text = viewModel.githubURL
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
