//
//  BorderColor.swift
//  GithubFollower
//
//  Created by Minseong Kang on 2023/10/07.
//

import UIKit

enum BorderColor {
    case white
    
    var value: CGColor {
        switch self {
        case .white:
            return UIColor.white.cgColor
        }
    }
}

