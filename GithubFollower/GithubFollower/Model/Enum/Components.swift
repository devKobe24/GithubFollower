//
//  Components.swift
//  GithubFollower
//
//  Created by Minseong Kang on 2023/10/13.
//

enum Components {
    case githubScheme
    case githubHost
    case githubUserPath
    case githubFollowersPath
    
    var localized: String {
        switch self {
        case .githubScheme:
            return "https"
        case .githubHost:
            return "api.github.com"
        case .githubUserPath:
            return "users"
        case .githubFollowersPath:
            return "followers"
        }
    }
}
