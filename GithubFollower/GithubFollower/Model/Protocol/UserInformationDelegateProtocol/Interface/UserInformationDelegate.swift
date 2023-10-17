//
//  UserInformationDelegate.swift
//  GithubFollower
//
//  Created by Minseong Kang on 10/17/23.
//

protocol UserInformationDelegate: AnyObject {
    func didTapGithubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}
