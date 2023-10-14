//
//  UICollectionViewFlowLayout+.swift
//  GithubFollower
//
//  Created by Minseong Kang on 10/15/23.
//

import UIKit

extension UICollectionViewFlowLayout {
    func configureFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let widthOfView: CGFloat = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth: CGFloat = widthOfView - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth: CGFloat = availableWidth / 3
        let itemHeight: CGFloat = itemWidth + 40
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(
            top: padding,
            left: padding,
            bottom: padding,
            right: padding
        )
        flowLayout.itemSize = CGSize(
            width: itemWidth,
            height: itemHeight
        )
        
        return flowLayout
    }
}
