//
//  NetworkManagerProtocol.swift
//  GithubFollower
//
//  Created by Minseong Kang on 2023/10/08.
//

import Foundation
import OSLog

struct NetworkManagerProtocol: NetworkManageable {
    var urlSession: URLSessionable
    
    init(urlSession: URLSessionable = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func getFollower(for username: String, perPage: Int, page: Int, completionHandler: @escaping ([Follower]?, ErrorMessage?) -> Void) {
        
        var components = URLComponents()
        components.scheme = Components.githubScheme.localized
        components.host = Components.githubHost.localized
        components.path = "/\(Components.githubUserPath.localized)/\(username)/\(Components.githubFollowersPath.localized)"
        
        let perPage = URLQueryItem(name: QueryItem.perPage.name, value: "\(perPage)")
        let page = URLQueryItem(name: QueryItem.page.name, value: "\(page)")
        
        components.queryItems = [
            perPage,
            page
        ]
        
        guard let url = components.url else {
            completionHandler(nil, ErrorMessage.invalidRequest)
            return
        }
        
        let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completionHandler(nil, ErrorMessage.unableRequest)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completionHandler(nil, ErrorMessage.invalidServer)
                return
            }
            
            let successRange = (200...299)
            
            if #available(iOS 16.0, *) {
                guard successRange.contains(response.statusCode) else {
                    Logger().error("\(response.statusCode) Error")
                    completionHandler(nil, ErrorMessage.invalidResponse)
                    return
                }
            } else {
                guard successRange ~= response.statusCode else {
                    Logger().error("\(response.statusCode) Error")
                    completionHandler(nil, ErrorMessage.invalidResponse)
                    return
                }
            }
            
            guard let data = data else {
                completionHandler(nil, ErrorMessage.invalidResponse)
                return
            }
            
            do {
                let decoder = JSONDecodeProtocol()
                let followerListData = try decoder.decodeJSON(type: [Follower].self, data: data)
                completionHandler(followerListData, nil)
            } catch {
                completionHandler(nil, ErrorMessage.invalidServer)
            }
        }
        dataTask.resume()
    }
}
