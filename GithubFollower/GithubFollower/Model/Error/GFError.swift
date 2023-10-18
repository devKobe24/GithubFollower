//
//  GFError.swift
//  GithubFollower
//
//  Created by Minseong Kang on 2023/10/14.
//
import Foundation

enum GFError: LocalizedError {
    case invalidRequest
    case unableRequest
    case invalidResponse
    case invalidServer
    case unableToFavorite
    case alreadyInFavorite
    
    var errorDescription: String? {
        switch self {
        case .invalidRequest:
            return "유효하지 않은 요청입니다. 다시 시도해 주세요."
        case .unableRequest:
            return "요청을 완료할 수 없습니다. 인터넷 연결을 확인해주세요."
        case .invalidResponse:
            return "서버로부터의 유효하지 않은 응답입니다. 다시 시도해 주세요."
        case .invalidServer:
            return "서버로부터 유효하지 않은 데이터를 전달받았습니다. 다시 시도해 주세요."
        case .unableToFavorite:
            return "이 유저를 추가할 수 없습니다. 다시 시도해 주세요."
        case .alreadyInFavorite:
            return "이 유저는 이미 추가 되어있습니다."
        }
    }
}
