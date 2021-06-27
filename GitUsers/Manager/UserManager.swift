//
//  UserManager.swift
//  GitUsers
//
//  Created by Jules Gilos on 6/27/21.
//

import Alamofire
import RxSwift
import RxRealm

protocol UserManagerProtocol {
    func requestUsers(since userId: Int)
    func fetchCachedUsers(query: String?) -> Observable<[User]>
}

struct UserManager: UserManagerProtocol {
    enum Endpoints {
        static let USERS = "https://api.github.com/users?"
    }
    
    public func requestUsers(since userId: Int = 0) {
        let parameters = [
            "since" : userId
        ]
        AFWrapper.request(urlString: Endpoints.USERS, parameters: parameters, success: { json in
            let objects = JSONModelHelper.parse(json: json, decodable: [User].self) as! [User]
            RealmManager.shared.createOrUpdate(objects)
        }, failure: { error in
            // Error
        })
    }
    
    public func fetchCachedUsers(query: String? = "") -> Observable<[User]> {
        var objects = RealmManager.shared.read(User.self)
            .sorted(byKeyPath: "id", ascending: true)
        if let query = query,
           !query.isEmpty {
            objects = objects.filter("login CONTAINS[cd] %@", query)
        }
        return Observable.array(from: objects)
    }
}


