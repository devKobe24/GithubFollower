//
//  AssetImages.swift
//  GithubFollower
//
//  Created by Minseong Kang on 2023/10/04.
//

enum AssetImages {
    case ghLogoImage
    
    var localized: String {
        switch self {
        case .ghLogoImage:
            return "gh-logo"
        }
    }
}
