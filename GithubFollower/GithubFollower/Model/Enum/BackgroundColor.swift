//
//  BackgroundColor.swift
//  GithubFollower
//
//  Created by Minseong Kang on 2023/10/07.
//

import UIKit

enum BackgroundColor {
    case clearShadow
    
    var value: UIColor {
        switch self {
        case .clearShadow:
            return UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        }
    }
}
