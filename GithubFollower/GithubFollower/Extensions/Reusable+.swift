//
//  Reusable+.swift
//  GithubFollower
//
//  Created by Minseong Kang on 10/14/23.
//

import UIKit

extension Reusable where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
