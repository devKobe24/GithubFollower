//
//  ImageCacheable.swift
//  GithubFollower
//
//  Created by Minseong Kang on 10/16/23.
//

import UIKit

protocol ImageCacheable {
    static var shared: NSCache<NSString, UIImage> { get }
}

