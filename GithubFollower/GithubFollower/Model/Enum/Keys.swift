//
//  Keys.swift
//  GithubFollower
//
//  Created by Minseong Kang on 10/18/23.
//

enum Keys {
    case favorites
    
    var localized: String {
        switch self {
        case .favorites:
            return "favorites"
        }
    }
}
