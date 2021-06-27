//
//  UserDetailsViewModel.swift
//  GitUsers
//
//  Created by Jules Gilos on 6/28/21.
//

import Foundation
import RxSwift

struct UserDetailsViewModel {
    let user: User
    
    var deets: BehaviorSubject<[(String, String)]> = BehaviorSubject(value: [])
    
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
        return user.url ?? "GitHub Link"
    }
    
    static let empty = "None"
    
    func fetchDeets() {
        let deets = [
            ("Node ID", value(of: user.nodeId)),
            ("Gravatar ID", value(of: user.gravatarId)),
            ("Followers", value(of: user.followersUrl)),
            ("Following", value(of: user.followingUrl)),
            ("Gists", value(of: user.gistsUrl)),
            ("Starred", value(of: user.starredUrl)),
            ("Subscriptions", value(of: user.subscriptionsUrl)),
            ("Organizations", value(of: user.organizationsUrl)),
            ("Repositories", value(of: user.reposUrl)),
            ("Events", value(of: user.eventsUrl)),
            ("Received Events", value(of: user.receivedEventsUrl))]
        self.deets.onNext(deets)
    }
    
    func value(of string: String?) -> String {
        if let string = string,
           !string.isEmpty {
            return string
        } else {
            return UserDetailsViewModel.empty
        }
    }
    
    init(from model: UserViewModel) {
        self.user = model.user
    }
}
