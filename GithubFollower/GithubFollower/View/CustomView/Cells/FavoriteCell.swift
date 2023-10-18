//
//  FavoriteCell.swift
//  GithubFollower
//
//  Created by Minseong Kang on 10/18/23.
//

import UIKit

final class FavoriteCell: UITableViewCell, Reusable {
    let avatarImageView: GFAvatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel: GFTitleLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCell()
        configureAvatarImageView()
        configureUsernameLabel()
        constraintsAvatarImageView()
        constraintsUsernameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favorite: Follower) {
        usernameLabel.text = favorite.login
        avatarImageView.downloadImage(from: favorite.avatarUrl)
    }
}

extension FavoriteCell {
    private func configureCell() {
        accessoryType = .disclosureIndicator
    }
    
    private func configureAvatarImageView() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(avatarImageView)
    }
    
    private func configureUsernameLabel() {
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(usernameLabel)
    }
    
    private func constraintsAvatarImageView() {
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            avatarImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/1.4),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor, multiplier: 1)
        ])
    }
    
    private func constraintsUsernameLabel() {
        NSLayoutConstraint.activate([
            usernameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            usernameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/2.1)
        ])
    }
}
