//
//  QueryItem.swift
//  GithubFollower
//
//  Created by Minseong Kang on 2023/10/13.
//

enum QueryItem {
    case perPage
    case page
    
    var name: String {
        switch self {
        case .perPage:
            return "per_page"
        case .page:
            return "page"
        }
    }
}
