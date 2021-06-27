//
//  UserListViewModel.swift
//  GitUsers
//
//  Created by Jules Gilos on 6/27/21.
//

import RxSwift

final class UserListViewModel {
    let disposeBag = DisposeBag()
    let title = "GitHub Users"

    var users: BehaviorSubject<[UserViewModel]> = BehaviorSubject(value: [])
    var query = PublishSubject<String>()
    var lastUserId = 0
    
    var isSearching = false
    
    private let manager: UserManagerProtocol
    
    init(manager: UserManagerProtocol = UserManager()) {
        self.manager = manager
        
        query.asObservable().subscribe { text in
            self.isSearching = !text.isEmpty
        }.disposed(by: disposeBag)
        
        users.subscribe { viewModels in
            self.lastUserId = viewModels.element?.last?.user.id ?? 0
        }.disposed(by: disposeBag)
    }
    
    func fetchUserViewModels(query: String? = "") -> Observable<[UserViewModel]> {
        manager.fetchCachedUsers(query: query).map { $0.map { UserViewModel(from: $0) } }
    }
    
    func requestUserViewModels(since userId: Int) {
        manager.requestUsers(since: userId)
    }
    
    func isLast(viewModel: UserViewModel?) -> Bool {
        guard let viewModel = viewModel
        else {
            return false
        }
        return viewModel.user.id == lastUserId
    }
}
