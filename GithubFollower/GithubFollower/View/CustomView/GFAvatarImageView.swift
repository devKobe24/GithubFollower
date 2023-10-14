//
//  GFAvatarImageView.swift
//  GithubFollower
//
//  Created by Minseong Kang on 10/14/23.
//

import UIKit

final class GFAvatarImageView: UIImageView {
    
    let placeHolderImage: UIImage
    
    init(placeHolderImage: UIImage) {
        self.placeHolderImage = placeHolderImage
        super.init(frame: .zero)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = self.placeHolderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
}
