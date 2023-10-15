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
    let networkManager: NetworkManager
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>?
    
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
        getFollower()
        
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
    }

    private func getFollower() {
        // MARK: - TEST
        networkManager.getFollower(
            username: username,
            perPage: 100,
            page: 1
        ) { [weak self] result in
            switch result {
            case .success(let followers):
                self?.followers = followers
                self?.updateData()
                
            case .failure(let error):
                self?.presentGFAlertOnMainThread(
                    alertTitle: "Bad Stuff Happend",
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
    
    private func updateData() {
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
