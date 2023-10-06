//
//  UINavigationController+.swift
//  GithubFollower
//
//  Created by Minseong Kang on 2023/10/03.
//

import UIKit

extension UINavigationController {
    func createNavigationController(
        with viewController: UIViewController,
        title: String,
        tabBarItem: UITabBarItem.SystemItem,
        tag: Int
    ) -> UINavigationController {
        viewController.title = title
        viewController.tabBarItem = UITabBarItem(
            tabBarSystemItem: tabBarItem,
            tag: tag
        )
        
        return UINavigationController(rootViewController: viewController)
    }
}
