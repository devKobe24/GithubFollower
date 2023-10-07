//
//  Follower.swift
//  GithubFollower
//
//  Created by Minseong Kang on 2023/10/07.
//

struct Follower: Decodable {
    var login: String
    var avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
}
