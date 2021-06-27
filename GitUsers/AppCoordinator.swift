//
//  AppCoordinator.swift
//  GitUsers
//
//  Created by Jules Gilos on 6/27/21.
//

import UIKit

class AppCoordinator {
    
    private let window: UIWindow
    private var navigationController = UINavigationController()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let vc = UserListViewController.instantiate(with: UserListViewModel())
        vc.coordinator = self
        navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.prefersLargeTitles = true
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func userDetails(viewModel: UserDetailsViewModel) {
        let vc = UserDetailsViewController.instantiate(with: viewModel)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
