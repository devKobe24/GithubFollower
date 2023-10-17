//
//  GFRepoAndGistItemViewController.swift
//  GithubFollower
//
//  Created by Minseong Kang on 10/17/23.
//

import UIKit

final class GFRepoAndGistItemViewController: GFItemInformationViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
}

extension GFRepoAndGistItemViewController {
    private func configureItems() {
        leftItemInfoView.set(itemInfoType: .repos, withCount: userData.publicRepos)
        rightItemInfoView.set(itemInfoType: .gists, withCount: userData.publicGists)
        commonButton.set(backgorundColor: .systemPurple, title: "Github Profile")
    }
}
