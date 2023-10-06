//
//  GFAlertViewController.swift
//  GithubFollower
//
//  Created by Minseong Kang on 2023/10/06.
//

import UIKit

final class GFAlertViewController: UIViewController {
    
    private let containerView: GFContainerView = {
        let view = GFContainerView()
        
        return view
    }()
    
    private let titleLabel : GFTitleLabel = {
        let label = GFTitleLabel(textAlignment: .center,
                                 fontSize: 20)
        return label
    }()
    
    private let messageLabel: GFBodyLabel = {
        let label = GFBodyLabel(textAlignment: .center)
        
        return label
    }()
    
    private let okButton: UIButton = {
        let button = GFButton(backgroundColor: .systemPink,
                              title: "OK")
        return button
    }()
    
    private var alertTitle: String?
    private var message: String?
    private var buttonTitle: String?
    
    init(alertTitle: String?,
         message: String?,
         buttonTitle: String?) {
        super.init(nibName: nil, bundle: nil)
        
        self.alertTitle = alertTitle
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        configureContainerView()
        configureTitleLabel()
        configureOkButton()
        configureMessageLabel()
    }
    
    private func initialSetup() {
        view.backgroundColor = BackgroundColor.clearShadow.value
    }
}

extension GFAlertViewController {
    
    private func configureContainerView() {
        view.addSubview(containerView)
        
        constraintsContainerViewUI()
    }
    
    private func constraintsContainerViewUI() {
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3),
            containerView.widthAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 3.3/3)
        ])
    }
    
    private func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? ErrorMessage.alertTitle.localized
        
        constraintsTitleLabelUI()
    }
    
    private func constraintsTitleLabelUI() {
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/5)
        ])
    }
    
    private func configureOkButton() {
        containerView.addSubview(okButton)
        okButton.setTitle(buttonTitle ?? ErrorMessage.okButtonTitle.localized, for: .normal)
        okButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        
        constrainsOkButtonUI()
    }
    
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
    
    private func constrainsOkButtonUI() {
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            okButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            okButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            okButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            okButton.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/5)
        ])
    }
    
    private func configureMessageLabel() {
        containerView.addSubview(messageLabel)
        messageLabel.text = message ?? ErrorMessage.messageLabel.localized
        messageLabel.numberOfLines = 4
        
        constraintsMessageLabelUI()
    }
    
    private func constraintsMessageLabelUI() {
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: okButton.topAnchor, constant: -12)
        ])
    }
    
}
