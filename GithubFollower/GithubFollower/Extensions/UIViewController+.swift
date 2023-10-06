//
//  UIViewController+.swift
//  GithubFollower
//
//  Created by Minseong Kang on 2023/10/07.
//

import UIKit

extension UIViewController {
    
    func presentGFAlertOnMainThread(alertTitle: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertViewController = GFAlertViewController(alertTitle: alertTitle,
                                                            message: message,
                                                            buttonTitle: buttonTitle)
            alertViewController.modalPresentationStyle = .overFullScreen
            alertViewController.modalTransitionStyle = .crossDissolve
            self.present(alertViewController, animated: true)
        }
    }
}
