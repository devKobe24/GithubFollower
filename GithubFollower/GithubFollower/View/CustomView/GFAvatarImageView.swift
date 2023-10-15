//
//  GFAvatarImageView.swift
//  GithubFollower
//
//  Created by Minseong Kang on 10/14/23.
//

import UIKit
import OSLog

final class GFAvatarImageView: UIImageView {
    let downloadImageManager: DownloadImageManager = DownloadImageManager()
    
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
    
    func downloadImage(from urlString: String) {
        downloadImageManager.downloadImage(from: urlString) { [weak self] result in
            switch result {
            case .success(let downloadImage):
                DispatchQueue.main.async {
                    self?.image = downloadImage
                }
            case .failure(let error):
                Logger().error("\(error.localizedDescription) 발생.")
            }
        }
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
    }
}
