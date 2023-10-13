//
//  ErrorMessage.swift
//  GithubFollower
//
//  Created by Minseong Kang on 2023/10/07.
//

enum AlertErrorMessage {
    case alertTitle
    case okButtonTitle
    case messageLabel
    
    var localized: String {
        switch self {
        case .alertTitle:
            return "얼럿 타이틀이 잘못되었습니다."
        case .okButtonTitle:
            return "OK 버튼 타이틀이 잘못되었습니다."
        case .messageLabel:
            return "Request를 완료할 수 없습니다."
        }
    }
}
