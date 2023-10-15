//
//  SceneDelegate.swift
//  GithubFollower
//
//  Created by Minseong Kang on 2023/10/03.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        UINavigationBar().configureNavigationBarTintColor(tintColor: .systemGreen)
        let rootNetworkManager: NetworkManager = NetworkManager()
        let searchNavigationController = UINavigationController().createNavigationController(
            with: SearchViewController(networkManager: rootNetworkManager),
            title: "Search",
            tabBarItem: .search,
            tag: 0
        )
        
        let favoriteListNavigationController = UINavigationController().createNavigationController(
            with: FavoriteListViewController(),
            title: "Favorites",
            tabBarItem: .favorites,
            tag: 1
        )
        
        let rootTabBarController = UITabBarController().createTabBarController(
            tintColor: .systemGreen,
            viewControllers: [
                searchNavigationController,
                favoriteListNavigationController
            ]
        )
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = rootTabBarController
        window?.makeKeyAndVisible()
    }
}

