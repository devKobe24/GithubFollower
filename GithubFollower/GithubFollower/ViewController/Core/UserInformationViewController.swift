//
//  UserInformationViewController.swift
//  GithubFollower
//
//  Created by Minseong Kang on 10/16/23.
//

import UIKit

final class UserInformationViewController: UIViewController {
    
    let headerView: UIView = UIView()
    let githubRepoAndGistView: UIView = UIView()
    let getFollowerAndFollowingView: UIView = UIView()
    let dateLabel: GFBodyLabel = GFBodyLabel(textAlignment: .center)
    
    var networkManager: NetworkManager
    var username: String?
    weak var delegate: FollowerListViewControllerDelegate?
    
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
        
        configureDateLabel()
        constraintsDateLabel()
        
        getUsetInfo()
    }
}

extension UserInformationViewController {
    private func getUsetInfo() {
        guard let username = self.username else { return }
        
        networkManager.getUserInfo(
            username: username
        ) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let userData):
                DispatchQueue.main.async {
                    self.configureUIElements(with: userData)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(alertTitle: "Error!!", message: error.localizedDescription, buttonTitle: "OK.")
            }
        }
    }
    
    private func configureUIElements(with userData: User) {
        let repoAndGistItemViewController = GFRepoAndGistItemViewController(userData: userData)
        repoAndGistItemViewController.delegate = self
        
        let followerAndFollowingViewController = GFFollowerAndFollowingViewController(userData: userData)
        followerAndFollowingViewController.delegate = self
        
        self.add(childViewController: GFUserInfoHeaderViewController(userData: userData), to: self.headerView)
        self.add(childViewController: repoAndGistItemViewController, to: self.githubRepoAndGistView)
        self.add(childViewController: followerAndFollowingViewController, to: self.getFollowerAndFollowingView)
        self.dateLabel.text = "Github since \(userData.createdAt.convertDateToDisplayFormat())"
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
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            headerView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    private func configureGithubRepoView() {
        githubRepoAndGistView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(githubRepoAndGistView)
    }
    
    private func constraintsGithubRepoView() {
        let height = (view.bounds.height) - (view.bounds.height - 140)
        
        NSLayoutConstraint.activate([
            githubRepoAndGistView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            githubRepoAndGistView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            githubRepoAndGistView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            githubRepoAndGistView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    private func configureGitgistView() {
        getFollowerAndFollowingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(getFollowerAndFollowingView)
    }
    
    private func constraintsGitgistView() {
        let height = (view.bounds.height) - (view.bounds.height - 140)
        
        NSLayoutConstraint.activate([
            getFollowerAndFollowingView.topAnchor.constraint(equalTo: githubRepoAndGistView.bottomAnchor, constant: padding),
            getFollowerAndFollowingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            getFollowerAndFollowingView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            getFollowerAndFollowingView.heightAnchor.constraint(equalToConstant: height)
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

extension UserInformationViewController {
    private func configureDateLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateLabel)
    }
    
    private func constraintsDateLabel() {
        let height = (view.bounds.height) - (view.bounds.height-18)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: getFollowerAndFollowingView.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: height)
        ])
    }
}

extension UserInformationViewController: UserInformationDelegate {
    func didTapGithubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(alertTitle: "유효하지 않은 URL", message: "이 URL은 유효하지 않은 URL 입니다.", buttonTitle: "OK")
            return
        }
        
        presentSafariViewController(with: url)
    }
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(alertTitle: "팔로워가 없습니다.", message: "이 유저는 팔로워가 없습니다🥲.", buttonTitle: "OK")
            return
        }
        
        delegate?.didRequestFollowers(for: user.login)
        
        self.dismiss(animated: true)
    }
}
