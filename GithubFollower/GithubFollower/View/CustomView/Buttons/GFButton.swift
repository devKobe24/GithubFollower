//
//  GFButton.swift
//  GithubFollower
//
//  Created by Minseong Kang on 2023/10/03.
//

import UIKit

final class GFButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
}

extension GFButton {
    func set(backgorundColor: UIColor, title: String) {
        self.backgroundColor = backgorundColor
        setTitle(title, for: .normal)
    }
}
