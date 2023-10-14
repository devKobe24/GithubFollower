//
//  Follower.swift
//  GithubFollower
//
//  Created by Minseong Kang on 2023/10/07.
//

import Foundation

struct Follower: Decodable, Hashable {
    var uuid: UUID = UUID()
    var login: String
    var avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
}
