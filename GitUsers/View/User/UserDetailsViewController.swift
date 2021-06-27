//
//  UserDetailsViewController.swift
//  GitUsers
//
//  Created by Jules Gilos on 6/28/21.
//

import Foundation

import UIKit
import RxSwift
import RxCocoa

class UserDetailsViewController: UIViewController {
    private var viewModel: UserDetailsViewModel!
    let disposeBag = DisposeBag()
    var coordinator: AppCoordinator?
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    static func instantiate(with viewModel: UserDetailsViewModel) -> UserDetailsViewController {
        let storyboard = UIStoryboard(name: "Users", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "User Details") as! UserDetailsViewController
        viewController.viewModel = viewModel
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Navigation
        navigationItem.title = viewModel.username
        // Avatar
        avatarImageView.kf.setImage(with: viewModel.avatar)
        // TableView
        viewModel.deets.bind(to: tableView.rx.items(cellIdentifier: UserDetailTableViewCell.Constants.identifier,
                                                                    cellType: UserDetailTableViewCell.self)) { index, deet, cell in
            cell.setup(name: deet.0, value: deet.1)
        }.disposed(by: disposeBag)
        viewModel.fetchDeets()
    }
}
