//
//  ImageCacheManager.swift
//  GithubFollower
//
//  Created by Minseong Kang on 10/15/23.
//

import UIKit

final class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
