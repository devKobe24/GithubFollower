//
//  UserInformationViewController.swift
//  GithubFollower
//
//  Created by Minseong Kang on 10/16/23.
//

import UIKit

final class UserInformationViewController: UIViewController {
    
    var networkManager: NetworkManager
    var username: String?
    
    init(username: String?, networkManager: NetworkManager) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
        self.username = username
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        configureDoneButton()
        guard let username = username else { return }
        networkManager.getUserInfo(
            username: username
        ) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let userData):
                print("USER DATA ==> \(userData)")
            case .failure(let error):
                self.presentGFAlertOnMainThread(alertTitle: "Error!!", message: error.localizedDescription, buttonTitle: "OK.")
            }
        }
    }
}

extension UserInformationViewController {
    private func initialSetup() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureDoneButton() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dimissUserInformationViewController))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc private func dimissUserInformationViewController() {
        dismiss(animated: true)
    }
}
