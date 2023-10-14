//
//  SearchViewController.swift
//  GithubFollower
//
//  Created by Minseong Kang on 2023/10/03.
//

import UIKit
import OSLog

final class SearchViewController: UIViewController {
    let networkManager: NetworkManagerProtocol
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let usernameTextField: GFTextField = {
        let textField = GFTextField()
        
        return textField
    }()
    
    let getFollowerButton: GFButton = {
        let button = GFButton(
            backgroundColor: .systemGreen,
            title: "Get Followers"
        )
        
        return button
    }()
    
    var isUsernameEmpty: Bool {
        guard let username = usernameTextField.text else {
            
            return false
        }
        
        switch username {
        case "":
            return false
        default:
            return true
        }
    }
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureLogoImageView()
        configureUsernameTextField()
        configureGetFollowerButton()
        createDismissKeyboardTagGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension SearchViewController {
    
    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.image = UIImage(named: AssetImages.ghLogoImage.localized)
        
        configureLogoImageViewUI()
    }
    
    private func configureLogoImageViewUI() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.53/3),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor, multiplier: 1)
        ])
    }
    
    private func configureUsernameTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        
        configureUsernameTextFieldUI()
    }
    
    private func configureUsernameTextFieldUI() {
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.widthAnchor.constraint(equalTo: logoImageView.widthAnchor, multiplier: 1.5),
            usernameTextField.heightAnchor.constraint(equalTo: logoImageView.heightAnchor, multiplier: 1/4)
        ])
    }
    
    private func configureGetFollowerButton() {
        view.addSubview(getFollowerButton)
        getFollowerButton.addTarget(self, action: #selector(pushFollowerListViewController), for: .touchUpInside)
        
        configureGetFollowerButtonUI()
    }
    
    @objc private func pushFollowerListViewController() {
        guard isUsernameEmpty else {
            presentGFAlertOnMainThread(alertTitle: "Empty Username",
                                       message: "Please enter a username. We need to know who to look for 😀.",
                                       buttonTitle: "OK")
            Logger().debug("Empty Username")
            return
        }
        guard let username = usernameTextField.text else { return }
        let followerListViewController = FollowerListViewController(networkManager: self.networkManager, username: username)
        followerListViewController.title = username
        navigationController?.pushViewController(followerListViewController, animated: true)
    }
    
    private func configureGetFollowerButtonUI() {
        NSLayoutConstraint.activate([
            getFollowerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            getFollowerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getFollowerButton.widthAnchor.constraint(equalTo: usernameTextField.widthAnchor, multiplier: 1),
            getFollowerButton.heightAnchor.constraint(equalTo: usernameTextField.heightAnchor, multiplier: 1),
        ])
    }
    
    private func createDismissKeyboardTagGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListViewController()
        
        return true
    }
}
