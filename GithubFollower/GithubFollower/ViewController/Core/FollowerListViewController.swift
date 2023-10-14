//
//  FollowerListViewController.swift
//  GithubFollower
//
//  Created by Minseong Kang on 2023/10/05.
//

import UIKit

final class FollowerListViewController: UIViewController {
    
    var username: String
    let networkManager: NetworkManagerProtocol
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = configureFlowLayout()
        
        var collectionView = UICollectionView(
            frame: self.view.bounds,
            collectionViewLayout: flowLayout)
        
        collectionView.backgroundColor = .systemPink
        collectionView.register(
            FollowerCell.self,
            forCellWithReuseIdentifier: FollowerCell.reuseIdentifier
        )
        
        return collectionView
    }()
    
    init(networkManager: NetworkManagerProtocol, username: String) {
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
    
    private func configureFlowLayout() -> UICollectionViewFlowLayout {
        let widthOfView: CGFloat = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth: CGFloat = widthOfView - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth: CGFloat = availableWidth / 3
        let itemHeight: CGFloat = availableWidth + 40
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(
            top: padding,
            left: padding,
            bottom: padding,
            right: padding
        )
        flowLayout.itemSize = CGSize(
            width: itemWidth,
            height: itemHeight
        )
        
        return flowLayout
    }
    
    private func getFollower() {
        // MARK: - TEST
        networkManager.getFollower(
            username: username,
            perPage: 100,
            page: 1
        ) { result in
            switch result {
            case .success(let followers):
                print(followers)
            case .failure(let error):
                self.presentGFAlertOnMainThread(
                    alertTitle: "Bad Stuff Happend",
                    message: error.localizedDescription,
                    buttonTitle: "OK"
                )
            }
        }
    }
}
