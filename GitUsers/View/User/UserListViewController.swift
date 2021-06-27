//
//  ViewController.swift
//  GitUsers
//
//  Created by Jules Gilos on 6/27/21.
//

import UIKit
import RxSwift
import RxCocoa

class UserListViewController: UIViewController, UITextFieldDelegate {
    private var viewModel: UserListViewModel!
    let disposeBag = DisposeBag()
    var coordinator: AppCoordinator?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    static func instantiate(with viewModel: UserListViewModel) -> UserListViewController {
        let storyboard = UIStoryboard(name: "Users", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "User List") as! UserListViewController
        viewController.viewModel = viewModel
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Navigation
        navigationItem.title = viewModel.title
        // TableView
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.sectionHeaderHeight = 0
        
        self.updateUserList()
        
        viewModel.query.asObservable().subscribe { text in
            self.viewModel.fetchUserViewModels(query: text).subscribe { viewModel in
                self.viewModel.users.onNext(viewModel)
            }.disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
        
        updateSearchQuery()
        
        viewModel.users.bind(to: tableView.rx.items(cellIdentifier: UserTableViewCell.Constants.identifier,
                                                                    cellType: UserTableViewCell.self)) { index, viewModel, cell in
            cell.setup(with: viewModel)
        }.disposed(by: disposeBag)
        
        
        tableView.rx.willDisplayCell.subscribe(onNext: { cell, index in
            guard let cell = cell as? UserTableViewCell
            else {
                return
            }
            
            if self.viewModel.isLast(viewModel: cell.viewModel) && !self.viewModel.isSearching {
                self.updateUserList()
            }
        }).disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { index in
            guard let cell = self.tableView.cellForRow(at: index) as? UserTableViewCell,
                  let viewModel = cell.viewModel
            else {
                return
            }
            let details = UserDetailsViewModel(from:viewModel)
            self.coordinator?.userDetails(viewModel: details)
        }).disposed(by: disposeBag)
    }
    
    @IBAction func textFieldDidChange(_ sender: Any) {
        updateSearchQuery()
    }
    
    func updateSearchQuery() {
        viewModel.query.onNext(searchTextField.text ?? "")
    }
    
    func updateUserList() {
        self.viewModel.requestUserViewModels(since: self.viewModel.lastUserId)
    }
}
