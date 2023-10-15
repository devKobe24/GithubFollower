//
//  Downloadable.swift
//  GithubFollower
//
//  Created by Minseong Kang on 10/15/23.
//

import UIKit

protocol Downloadable {
    func downloadImage(from urlString: String, completionHandler: @escaping (Result<UIImage, GFError>) -> Void)
}
