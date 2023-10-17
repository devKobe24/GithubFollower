//
//  GFItemInfoView.swift
//  GithubFollower
//
//  Created by Minseong Kang on 10/17/23.
//

import UIKit

final class GFItemInfoView: UIView {
    
    let symbolImageView: UIImageView = UIImageView()
    let titleLabel: GFTitleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel: GFTitleLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSymbolImageView()
        configureTitleLabel()
        configureCountLabel()
        
        constraintsSymbolImageView()
        constraintsTitleLabel()
        constraintsConuntLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GFItemInfoView {
    private func configureSymbolImageView() {
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(symbolImageView)
    }
    
    private func constraintsSymbolImageView() {
        let width = (self.bounds.width) - (self.bounds.width - 20)
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: width),
            symbolImageView.heightAnchor.constraint(equalTo: symbolImageView.widthAnchor, multiplier: 1),
        ])
    }
    
    private func configureTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
    }
    
    private func constraintsTitleLabel() {
        let height = (self.bounds.height) - (self.bounds.height - 18)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    private func configureCountLabel() {
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(countLabel)
    }
    
    private func constraintsConuntLabel() {
        NSLayoutConstraint.activate([
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, multiplier: 1)
        ])
    }
}

extension GFItemInfoView {
    func set(itemInfoType: ItemInfoType, withCount count: Int) {
        switch itemInfoType {
        case .repos:
            guard let reposImage = UIImage(systemName: SFSymbols.folder.imageName) else { return }
            symbolImageView.image = reposImage
            titleLabel.text = "Public Repos"
            countLabel.text = String(count)
        case .gists:
            guard let gistsImage = UIImage(systemName: SFSymbols.textAlignleft.imageName) else { return }
            symbolImageView.image = gistsImage
            titleLabel.text = "Public Gists"
            countLabel.text = String(count)
        case .followers:
            guard let followersImage = UIImage(systemName: SFSymbols.heart.imageName) else { return }
            symbolImageView.image = followersImage
            titleLabel.text = "Followers"
            countLabel.text = String(count)
        case .following:
            guard let followingImage = UIImage(systemName: SFSymbols.personTwo.imageName) else { return }
            symbolImageView.image = followingImage
            titleLabel.text = "Following"
            countLabel.text = String(count)
        }
    }
}
