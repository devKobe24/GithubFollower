//
//  UserInformationViewController.swift
//  GithubFollower
//
//  Created by Minseong Kang on 10/16/23.
//

import UIKit

final class UserInformationViewController: UIViewController {
    
    let headerView: UIView = UIView()
    let githubRepoView: UIView = UIView()
    let gitgistView: UIView = UIView()
    
    var networkManager: NetworkManager
    var username: String?
    
    let padding: CGFloat = 20
    
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
        
        configureHeaderView()
        constraintsHeaderView()
        
        configureGithubRepoView()
        constraintsGithubRepoView()
        
        configureGitgistView()
        constraintsGitgistView()
        
        guard let username = username else { return }
        networkManager.getUserInfo(
            username: username
        ) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let userData):
                DispatchQueue.main.async {
                    self.add(
                        childViewController: GFUserInfoHeaderViewController(
                            user: userData
                        ),
                        to: self.headerView
                    )
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(alertTitle: "Error!!", message: error.localizedDescription, buttonTitle: "OK.")
            }
        }
    }
}

extension UserInformationViewController {
    private func configureHeaderView() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        
        headerView.backgroundColor = .systemBackground
    }
    
    private func constraintsHeaderView() {
        let height = (view.frame.height) - (view.frame.height - 180)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    private func configureGithubRepoView() {
        githubRepoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(githubRepoView)
        
        githubRepoView.backgroundColor = .systemPink
    }
    
    private func constraintsGithubRepoView() {
        let height = (view.bounds.height) - (view.bounds.height - 140)
        
        NSLayoutConstraint.activate([
            githubRepoView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            githubRepoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            githubRepoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            githubRepoView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    private func configureGitgistView() {
        gitgistView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gitgistView)
        
        gitgistView.backgroundColor = .systemBlue
    }
    
    private func constraintsGitgistView() {
        let height = (view.bounds.height) - (view.bounds.height - 140)
        
        NSLayoutConstraint.activate([
            gitgistView.topAnchor.constraint(equalTo: githubRepoView.bottomAnchor, constant: padding),
            gitgistView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            gitgistView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            gitgistView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    private func add(childViewController: UIViewController, to containerView: UIView) {
        addChild(childViewController)
        containerView.addSubview(childViewController.view)
        childViewController.view.frame = containerView.bounds
        childViewController.didMove(toParent: self)
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
