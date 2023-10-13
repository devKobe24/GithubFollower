//
//  NetworkManagerProtocol.swift
//  GithubFollower
//
//  Created by Minseong Kang on 2023/10/08.
//

import Foundation

struct NetworkManagerProtocol: NetworkManageable {
    var urlSession: URLSessionable
    
    init(urlSession: URLSessionable = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func getFollower(for username: String, perPage: Int, page: Int, completionHandler: @escaping ([Follower]?, String?) -> Void) {
        
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
            completionHandler(nil, "리퀘스트 URL 에러입니다.")
            return
        }
        
        let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completionHandler(nil, "에러가 발생했습니다.")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completionHandler(nil, "HTTP Response 에러가 발생했습니다.")
                return
            }
            
            let successRange = (200...299)
            
            if #available(iOS 16.0, *) {
                guard successRange.contains(response.statusCode) else {
                    completionHandler(nil, "\(response.statusCode) 에러 입니다.")
                    return
                }
            } else {
                guard successRange ~= response.statusCode else {
                    completionHandler(nil, "\(response.statusCode) 에러 입니다.")
                    return
                }
            }
            
            guard let data = data else {
                completionHandler(nil, "데이터가 존재하지 않습니다. 다시 시도해주세요.")
                return
            }
            
            do {
                let decoder = JSONDecodeProtocol()
                let followerListData = try decoder.decodeJSON(type: [Follower].self, data: data)
                completionHandler(followerListData, nil)
            } catch {
                completionHandler(nil, "데이터가 존재하지 않습니다. 다시 시도해주세요.")
            }
        }
        dataTask.resume()
    }
}
