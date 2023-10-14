//
//  FollowerCell.swift
//  GithubFollower
//
//  Created by Minseong Kang on 10/14/23.
//

import UIKit

final class FollowerCell: UICollectionViewCell, Reusable {
    let placeHolderImage: UIImage
    
    lazy var avatarImageView: GFAvatarImageView = {
        var avatarImageView = GFAvatarImageView(placeHolderImage: placeHolderImage)
        
        return avatarImageView
    }()
    
    let usernameLabel: GFTitleLabel = GFTitleLabel(
        textAlignment: .center,
        fontSize: 16
    )
    
    init(placeHolderImage: UIImage) {
        self.placeHolderImage = placeHolderImage
        super.init(frame: .zero)
        
        configureAvatarImageView()
        configureUsernameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FollowerCell {
    func setup(follower: Follower) {
        usernameLabel.text = follower.login
    }
}

extension FollowerCell {
    private func configureAvatarImageView() {
        let padding: CGFloat = 8
        
        addSubview(avatarImageView)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor, multiplier: 1)
        ])
    }
    
    private func configureUsernameLabel() {
        let padding: CGFloat = 8
        
        addSubview(usernameLabel)
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.widthAnchor.constraint(equalTo: avatarImageView.widthAnchor, multiplier: 1),
        ])
    }
}
