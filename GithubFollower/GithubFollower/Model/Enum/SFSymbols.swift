//
//  SFSymbols.swift
//  GithubFollower
//
//  Created by Minseong Kang on 10/17/23.
//

enum SFSymbols {
    case mappinAndEllipse
    case folder
    case textAlignleft
    case heart
    case personTwo
    
    var imageName: String {
        switch self {
        case .mappinAndEllipse:
            return "mappin.and.ellipse"
        case .folder:
            return "folder"
        case .textAlignleft:
            return "text.alignleft"
        case .heart:
            return "heart"
        case .personTwo:
            return "person.2"
        }
    }
}
