//
//  DecodeError.swift
//  GithubFollower
//
//  Created by Minseong Kang on 2023/10/08.
//

enum DecodeError: Error {
    case failedDecode
    
    var description: String {
        switch self {
        case .failedDecode:
            return "Failed decode data"
        }
    }
}
