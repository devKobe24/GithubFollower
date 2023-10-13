//
//  FollowerListViewController.swift
//  GithubFollower
//
//  Created by Minseong Kang on 2023/10/05.
//

import UIKit

final class FollowerListViewController: UIViewController {
    
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        
        // MARK: - TEST
        let networkManager = NetworkManagerProtocol()
        networkManager.getFollower(for: "devKobe24", perPage: 1, page: 1) { (followerListData, errorMessage) in
            guard let followerListData = followerListData else {
                self.presentGFAlertOnMainThread(alertTitle: "BAD STUFF HAPPEN", message: errorMessage!, buttonTitle: "OK")
                return
            }
            print("userData Followers => \(followerListData.count)")
            print(followerListData)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
     
        
        
    }
    
    private func initialSetup() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
