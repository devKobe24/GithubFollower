//
//  ErrorMessage.swift
//  GithubFollower
//
//  Created by Minseong Kang on 2023/10/07.
//

enum ErrorMessage {
    case alertTitle
    case okButtonTitle
    case messageLabel
    
    var localized: String {
        switch self {
        case .alertTitle:
            return "Alert Title went wrong"
        case .okButtonTitle:
            return "Ok Button went wrong"
        case .messageLabel:
            return "Unable to complete request"
        }
    }
}
