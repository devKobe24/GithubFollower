//
//  FavoriteListViewController.swift
//  GithubFollower
//
//  Created by Minseong Kang on 2023/10/03.
//

import UIKit

final class FavoriteListViewController: UIViewController {
    
    let tableView: UITableView = {
        var tableView = UITableView()
        tableView.register(
            FavoriteCell.self,
            forCellReuseIdentifier: FavoriteCell.reuseIdentifier
        )
        return tableView
    }()
    
    var favorites: [Follower] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureFavoriteListViewController()
        configureTableView()
        constraintsTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getFavorites()
    }
}

extension FavoriteListViewController {
    private func configureFavoriteListViewController() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func getFavorites() {
        PersistenceManager().retrieveFavorite { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favorites):
                if favorites.isEmpty {
                    self.showEmptyStateView(with: "즐겨찾기한 친구가 없어요😢\n어서 친구를 즐겨찾기에 추가해보세요🙌.", in: self.view)
                } else {
                    self.favorites = favorites
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(alertTitle: "ERROR!!👻", message: error.localizedDescription, buttonTitle: "OK")
            }
        }
    }
}

extension FavoriteListViewController {
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }
    
    private func constraintsTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension FavoriteListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = self.view.bounds.height / 10
        return height
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseIdentifier, for: indexPath) as? FavoriteCell else {
            return UITableViewCell()
        }
        
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let followerListViewController = FollowerListViewController(networkManager: NetworkManager(), username: favorite.login)
        followerListViewController.title = favorite.login
        
        navigationController?.pushViewController(followerListViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let favorite = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PersistenceManager().remove(favorite: favorite) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else { return }
            self.presentGFAlertOnMainThread(alertTitle: "ERROR!!", message: error.localizedDescription, buttonTitle: "OK")
        }
    }
}
