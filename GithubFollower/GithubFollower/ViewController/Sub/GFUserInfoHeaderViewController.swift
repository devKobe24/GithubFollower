//
//  GFUserInfoHeaderViewController.swift
//  GithubFollower
//
//  Created by Minseong Kang on 10/16/23.
//

import UIKit

class GFUserInfoHeaderViewController: UIViewController {
    
    let avatarImageView: GFAvatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel: GFTitleLabel = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel: GFSecondaryTitleLabel = GFSecondaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel: GFSecondaryTitleLabel = GFSecondaryTitleLabel(fontSize: 18)
    let bioLabel: GFBodyLabel = GFBodyLabel(textAlignment: .left)
    
    var user: User
    
    let padding: CGFloat = 20
    let textImagePadding: CGFloat = 12
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAvatarImageView()
        configureUsernameLabel()
        configureNamelabel()
        configureLocationImageView()
        configureLocationLabel()
        configureBioLabel()
        
        constraintsAvatarImageView()
        constraintsUsernameLabel()
        constraintsNamelabel()
        constrainsLocationImageView()
        constraintsLocationLabel()
        constraintsBioLabel()
    }
}

extension GFUserInfoHeaderViewController {
    private func configureAvatarImageView() {
        avatarImageView.downloadImage(from: user.avatarUrl)
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(avatarImageView)
    }
    
    private func constraintsAvatarImageView() {
        let width: CGFloat = (view.bounds.width) - (view.bounds.width - 90)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: width),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor, multiplier: 1)
        ])
    }
    
    private func configureUsernameLabel() {
        usernameLabel.text = user.login
        
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usernameLabel)
    }
    
    private func constraintsUsernameLabel() {
        let height: CGFloat = (view.bounds.height) - (view.bounds.height - 38)
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    private func configureNamelabel() {
        nameLabel.text = user.name ?? "N/A"
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
    }
    
    private func constraintsNamelabel() {
        let height: CGFloat = (view.bounds.height) - (view.bounds.height - 20)
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    private func configureLocationImageView() {
        guard let locationImage = UIImage(systemName: SFSymbols.mappinAndEllipse.imageName) else { return }
        locationImageView.image = locationImage
        locationImageView.tintColor = .secondaryLabel
        
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationImageView)
    }
    
    private func constrainsLocationImageView() {
        let width: CGFloat = (view.bounds.width) - (view.bounds.width - 20)
        
        NSLayoutConstraint.activate([
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: width),
            locationImageView.heightAnchor.constraint(equalTo: locationImageView.widthAnchor, multiplier: 1)
        ])
    }
    
    private func configureLocationLabel() {
        locationLabel.text = user.location ?? "N/A"
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationLabel)
    }
    
    private func constraintsLocationLabel() {
        let height = (view.bounds.height) - (view.bounds.height - 20)
        
        NSLayoutConstraint.activate([
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            locationLabel.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    private func configureBioLabel() {
        bioLabel.numberOfLines = 3
        bioLabel.text = user.bio ?? "N/A"
        
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bioLabel)
    }
    
    private func constraintsBioLabel() {
        let height = (view.bounds.height) - (view.bounds.height - 60)
        
        NSLayoutConstraint.activate([
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bioLabel.heightAnchor.constraint(equalToConstant: height)
        ])
    }
}
