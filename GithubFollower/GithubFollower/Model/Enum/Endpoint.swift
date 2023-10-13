//
//  URL.swift
//  GithubFollower
//
//  Created by Minseong Kang on 2023/10/08.
//

enum Endpoint {
    case base
    case user
    
    var url: String {
        switch self {
        case .base:
            return "https://api.github.com"
        case .user:
            return "https://api.github.com/users/"
        }
    }
}
