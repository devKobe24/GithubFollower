//
//  GFEmptyStateView.swift
//  GithubFollower
//
//  Created by Minseong Kang on 10/16/23.
//

import UIKit

final class GFEmptyStateView: UIView {
    
    let messgeLabel: GFTitleLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMessageLabel()
        configureLogoImageView()
        
        setupConstraintMessageLabel()
        setupConstraintLogoImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        messgeLabel.text = message
        
        configureMessageLabel()
        configureLogoImageView()
        
        setupConstraintMessageLabel()
        setupConstraintLogoImageView()
    }
}

extension GFEmptyStateView {
    private func configureMessageLabel() {
        addSubview(messgeLabel)
        
        messgeLabel.textAlignment = .center
        messgeLabel.numberOfLines = 3
        messgeLabel.textColor = .secondaryLabel
    }
    
    private func setupConstraintMessageLabel() {
        NSLayoutConstraint.activate([
            messgeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messgeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            messgeLabel.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/5),
        ])
    }
    
    private func configureLogoImageView() {
        addSubview(logoImageView)
        
        logoImageView.image = UIImage(named: AssetImages.ghEmptyStateLogo.localized)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraintLogoImageView() {
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 200),
            logoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 200)
        ])
    }
}
