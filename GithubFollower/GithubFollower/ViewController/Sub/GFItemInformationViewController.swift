//
//  GFItemInformationViewController.swift
//  GithubFollower
//
//  Created by Minseong Kang on 10/17/23.
//

import UIKit

final class GFItemInformationViewController: UIViewController {
    
    let stackView: UIStackView = UIStackView()
    let reposAndGistView: GFItemInfoView = GFItemInfoView()
    let followersAndFollowingView: GFItemInfoView = GFItemInfoView()
    let commonButton: GFButton = GFButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackgroundView()
        configureStackView()
        
        constraintsStackView()
        constraintsCommonButton()
    }
}

extension GFItemInformationViewController {
    private func configureBackgroundView() {
        let cornerRadius = (view.bounds.width) - (view.bounds.width - 18)
        view.layer.cornerRadius = cornerRadius
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configureStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(reposAndGistView)
        stackView.addArrangedSubview(followersAndFollowingView)
    }
    
    private func constraintsStackView() {
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2)
        ])
    }
    
    private func configureCommonButton() {
        commonButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(commonButton)
    }
    
    private func constraintsCommonButton() {
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            commonButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            commonButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            commonButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            commonButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2, constant: -16)
        ])
    }
}
