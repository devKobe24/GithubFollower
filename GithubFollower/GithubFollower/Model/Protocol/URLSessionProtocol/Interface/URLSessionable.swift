//
//  URLSessionable.swift
//  GithubFollower
//
//  Created by Minseong Kang on 2023/10/08.
//
import Foundation

typealias DataTaskCompletionHandler = @Sendable (Data?, URLResponse?, Error?) -> Void

protocol URLSessionable {
    func dataTask(with url: URL, completionHandler: @escaping DataTaskCompletionHandler) -> URLSessionDataTask
}
