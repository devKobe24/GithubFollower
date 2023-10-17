//
//  FollowerListViewControllerDelegate.swift
//  GithubFollower
//
//  Created by Minseong Kang on 10/17/23.
//

protocol FollowerListViewControllerDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}
