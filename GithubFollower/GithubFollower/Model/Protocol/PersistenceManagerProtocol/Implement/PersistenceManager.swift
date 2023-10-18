//
//  PersistenceManager.swift
//  GithubFollower
//
//  Created by Minseong Kang on 10/18/23.
//

import Foundation

struct PersistenceManager: PersistenceManagerable {
    let userDefault = UserDefaults.standard
    
    // MARK: - SEARCH
    func retrieveFavorite(completion: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = userDefault.object(forKey: Keys.favorites.localized) as? Data else {
            completion(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completion(.success(favorites))
        } catch {
            completion(.failure(.unableToFavorite))
        }
    }
    
    // MARK: - SAVE
    func save(favorites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            userDefault.setValue(encodedFavorites, forKey: Keys.favorites.localized)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
    
    // MARK: - UPDATE
    func update(favorite: Follower, completion: @escaping(GFError?) -> Void) {
        retrieveFavorite { result in
            
            switch result {
            case .success(let favorites):
                var retrieveFavorites: [Follower] = favorites
                guard !retrieveFavorites.contains(favorite) else {
                    completion(.alreadyInFavorite)
                    return
                }
                retrieveFavorites.append(favorite)
                completion(save(favorites: retrieveFavorites))
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    // MARK: - DELETE
    func remove(favorite: Follower, completion: @escaping(GFError?) -> Void) {
        retrieveFavorite { result in
            switch result {
            case .success(let favorites):
                var retrieveFavorites: [Follower] = favorites
                retrieveFavorites.removeAll {
                    $0.login == favorite.login
                }
            case .failure(let error):
                completion(error)
            }
        }
    }
}
