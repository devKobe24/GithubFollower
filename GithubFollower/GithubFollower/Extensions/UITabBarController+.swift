//
//  UITabBarController+.swift
//  GithubFollower
//
//  Created by Minseong Kang on 2023/10/03.
//

import UIKit

extension UITabBarController {
    func createTabBarController(
        tintColor: UIColor,
        viewControllers: [UIViewController]
    ) -> UITabBarController {
        UITabBar.appearance().tintColor = tintColor
        self.viewControllers = viewControllers
        
        return self
    }
}
