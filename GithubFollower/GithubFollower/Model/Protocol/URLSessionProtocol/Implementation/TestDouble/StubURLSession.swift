//
//  StubURLSession.swift
//  GithubFollowerTests
//
//  Created by Minseong Kang on 2023/10/08.
//

import Foundation

struct DummyData {
    let data: Data?
    let response: URLResponse?
    let error: Error?
    var completionHandler: DataTaskCompletionHandler? = nil
    
    func completion() {
        completionHandler?(data, response, error)
    }
}

class StubURLSession: URLSessionable {
    var dummayData: DummyData?
    
    init(dummayData: DummyData) {
        self.dummayData = dummayData
    }
    
    func dataTask(with url: URL, completionHandler: @escaping DataTaskCompletionHandler) -> URLSessionDataTask {
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        
        guard let stubURLSessionDataTask: StubURLSessionDataTask = urlSession.dataTask(with: url) as? StubURLSessionDataTask else {
            let urlSessionDataTask = urlSession.dataTask(with: url)
            return urlSessionDataTask
        }
        
        stubURLSessionDataTask.dummyData = dummayData
        stubURLSessionDataTask.completionHandler = completionHandler
        
        return stubURLSessionDataTask
    }
}

class StubURLSessionDataTask: URLSessionDataTask {
    var dummyData: DummyData?
    var completionHandler: DataTaskCompletionHandler?
    
    override func resume() {
        dummyData?.completion()
    }
}
