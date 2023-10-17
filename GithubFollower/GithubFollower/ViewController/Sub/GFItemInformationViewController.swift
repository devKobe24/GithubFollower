//
//  GFItemInformationViewController.swift
//  GithubFollower
//
//  Created by Minseong Kang on 10/17/23.
//

import UIKit

class GFItemInformationViewController: UIViewController {
    
    let stackView: UIStackView = UIStackView()
    let leftItemInfoView: GFItemInfoView = GFItemInfoView()
    let rightItemInfoView: GFItemInfoView = GFItemInfoView()
    let commonButton: GFButton = GFButton()
    
    var userData: User
    
    let padding: CGFloat = 20
    
    init(userData: User) {
        self.userData = userData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackgroundView()
        configureStackView()
        configureCommonButton()
        
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
        
        stackView.addArrangedSubview(leftItemInfoView)
        stackView.addArrangedSubview(rightItemInfoView)
    }
    
    private func constraintsStackView() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3)
        ])
    }
    
    private func configureCommonButton() {
        commonButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(commonButton)
    }
    
    private func constraintsCommonButton() {
        NSLayoutConstraint.activate([
            commonButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            commonButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            commonButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            commonButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3)
        ])
    }
}
