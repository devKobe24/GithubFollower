//
//  NetworkManageable.swift
//  GithubFollower
//
//  Created by Minseong Kang on 2023/10/08.
//

protocol NetworkManageable {
    func getFollower(for username: String, perPage: Int, page: Int, completionHandler: @escaping(Result<[Follower], GFError>) -> Void)
}
