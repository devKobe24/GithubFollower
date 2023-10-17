//
//  FollowerListViewController.swift
//  GithubFollower
//
//  Created by Minseong Kang on 2023/10/05.
//

import UIKit

final class FollowerListViewController: UIViewController {
    
    var username: String
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    let networkManager: NetworkManager
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>?
    var page: Int = 1
    var hasMoreFollowers: Bool = true
    var isSearchingUsername: Bool = false
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout().configureFlowLayout(in: view)
        
        var collectionView = UICollectionView(
            frame: self.view.bounds,
            collectionViewLayout: flowLayout)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(
            FollowerCell.self,
            forCellWithReuseIdentifier: FollowerCell.reuseIdentifier
        )
        
        return collectionView
    }()
    
    init(networkManager: NetworkManager, username: String) {
        self.networkManager = networkManager
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        configureCollectionView()
        configureSearchController()
        getFollower(username: username, page: page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension FollowerListViewController {
    
    private func initialSetup() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.delegate = self
    }

    private func getFollower(username: String, page: Int) {
        let containerView = showLoadingView()
        networkManager.getFollower(
            username: username,
            perPage: 100,
            page: page
        ) { [weak self] result in
            guard let self = self else { return }
            
            self.dismissLoadingView(containerView: containerView)
            switch result {
            case .success(let followers):
                if followers.count < 100 {
                    self.hasMoreFollowers = false
                }
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty {
                    let message = "이 유저는 팔로워가 없습니다.\n어서 팔로우 하세요 😉"
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, in: self.view)
                    }
                    return
                }
                self.updateData(on: self.followers)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(
                    alertTitle: "🤪Error🤪",
                    message: error.localizedDescription,
                    buttonTitle: "OK"
                )
            }
        }
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FollowerCell.reuseIdentifier,
                    for: indexPath
                ) as? FollowerCell else {
                    return UICollectionViewCell()
                }
                
                cell.setup(follower: follower)
                
                return cell
            }
        )
    }
    
    private func updateData(on followers: [Follower]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapShot.appendSections([.main])
        snapShot.appendItems(followers)
        self.dataSource?.apply(
            snapShot,
            animatingDifferences: true,
            completion: nil
        )
    }
}

extension FollowerListViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollower(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let items = isSearchingUsername ? filteredFollowers : followers
        let selectedFollower = items[indexPath.item]
        
        // MARK: - userInformationViewController
        /// userInformationViewController Modal
        /// > Apple Developer HIG의 Modality의 설명 중 "Always give people an obvious way to dismiss a modal view." 이라고 명시 되어 있습니다.
        /// > 즉, 항상 사용자에게 모달 뷰를 해제(Dismiss)할 수 있는 명확한 방법을 제공하라는 뜻 입니다.
        /// >
        /// >  https://developer.apple.com/design/human-interface-guidelines/modality
        let userInformationViewController = UserInformationViewController(
            username: selectedFollower.login,
            networkManager: self.networkManager
        )
        
        userInformationViewController.delegate = self
        
        let navigationController = UINavigationController(rootViewController: userInformationViewController)
        present(navigationController, animated: true)
    }
}

extension FollowerListViewController {
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = true
        navigationItem.searchController = searchController
    }
}

extension FollowerListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearchingUsername = false
        
        updateData(on: self.followers)
    }
}

extension FollowerListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty, filter != "" else {
            return
        }
        
        isSearchingUsername = true
        
        filteredFollowers = followers.filter({ followers in
            followers.login.lowercased().contains(filter.lowercased())
        })
        
        updateData(on: filteredFollowers)
    }
}

extension FollowerListViewController: FollowerListViewControllerDelegate {
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollower(username: username, page: page)
    }
}
