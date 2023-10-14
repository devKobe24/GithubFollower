//
//  GFAvatarImageView.swift
//  GithubFollower
//
//  Created by Minseong Kang on 10/14/23.
//

import UIKit

final class GFAvatarImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(placeHolderImage: UIImage) {
        image = placeHolderImage
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
    }
}
