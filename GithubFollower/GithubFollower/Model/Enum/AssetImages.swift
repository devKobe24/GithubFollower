//
//  AssetImages.swift
//  GithubFollower
//
//  Created by Minseong Kang on 2023/10/04.
//

enum AssetImages {
    case ghLogoImage
    case ghAvatarPlaceHolder
    case ghEmptyStateLogo
    
    var localized: String {
        switch self {
        case .ghLogoImage:
            return "gh-logo"
        case .ghAvatarPlaceHolder:
            return "avatar-placeholder"
        case .ghEmptyStateLogo:
            return "empty-state-logo"
        }
    }
}
