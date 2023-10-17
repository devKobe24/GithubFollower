//
//  GFFollowerAndFollowingViewController.swift
//  GithubFollower
//
//  Created by Minseong Kang on 10/17/23.
//

import UIKit

final class GFFollowerAndFollowingViewController: GFItemInformationViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItems()
    }
}

extension GFFollowerAndFollowingViewController {
    private func configureItems() {
        leftItemInfoView.set(itemInfoType: .followers, withCount: userData.followers)
        rightItemInfoView.set(itemInfoType: .following, withCount: userData.following)
        commonButton.set(backgorundColor: .systemGreen, title: "Get Followers")
    }
    
    override func didTapCommonButton() {
        delegate?.didTapGetFollowers(for: userData)
    }
}
