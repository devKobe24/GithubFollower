//
//  PersistenceManagerable.swift
//  GithubFollower
//
//  Created by Minseong Kang on 10/18/23.
//

protocol PersistenceManagerable {
    func retrieveFavorite(completion: @escaping(Result<[Follower], GFError>) -> Void)
    func save(favorites: [Follower]) -> GFError?
    func update(favorite: Follower, completion: @escaping(GFError?) -> Void)
    func remove(favorite: Follower, completion: @escaping(GFError?) -> Void)
}
