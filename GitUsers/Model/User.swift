//
//  User.swift
//  GitUsers
//
//  Created by Jules Gilos on 6/27/21.
//

import RealmSwift

@objcMembers class User: Object, Decodable {
    dynamic var login: String?
    dynamic var id: Int = 0
    dynamic var nodeId: String?
    dynamic var avatarUrl: String?
    dynamic var gravatarId: String?
    dynamic var url: String?
    dynamic var htmlUrl: String?
    dynamic var followersUrl: String?
    dynamic var followingUrl: String?
    dynamic var gistsUrl: String?
    dynamic var starredUrl: String?
    dynamic var subscriptionsUrl: String?
    dynamic var organizationsUrl: String?
    dynamic var reposUrl: String?
    dynamic var eventsUrl: String?
    dynamic var receivedEventsUrl: String?
    dynamic var type: String?
    dynamic var siteAdmin: Bool?
    
    enum CodingKeys: String, CodingKey {
        case login
        case id
        case nodeId = "node_id"
        case avatarUrl = "avatar_url"
        case gravatarId = "gravatar_id"
        case url
        case htmlUrl = "html_url"
        case followersUrl = "followers_url"
        case followingUrl = "following_url"
        case gistsUrl = "gists_url"
        case starredUrl = "starred_url"
        case subscriptionsUrl = "subscriptions_url"
        case organizationsUrl = "organizations_url"
        case reposUrl = "repos_url"
        case eventsUrl = "events_url"
        case receivedEventsUrl = "received_events_url"
        case type
        case siteAdmin = "site_admin"
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override required init() {
        super.init()
    }
}
