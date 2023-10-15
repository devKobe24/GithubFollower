//
//  GFContainerView.swift
//  GithubFollower
//
//  Created by Minseong Kang on 2023/10/07.
//

import UIKit

final class GFContainerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = BorderColor.white.value
        translatesAutoresizingMaskIntoConstraints = false
    }
}
