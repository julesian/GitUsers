//
//  UserViewModel.swift
//  GitUsers
//
//  Created by Jules Gilos on 6/27/21.
//

import Foundation

struct UserViewModel {
    let user: User
    
    var username: String {
        return user.login ?? "GitHub User"
    }
    
    var avatar: URL? {
        guard let stringUrl = user.avatarUrl
        else {
            return nil
        }
        return URL(string: stringUrl)
    }
    
    var githubURL: String {
        return user.htmlUrl ?? "GitHub Link"
    }
    
    init(from model: User) {
        self.user = model
    }
}
