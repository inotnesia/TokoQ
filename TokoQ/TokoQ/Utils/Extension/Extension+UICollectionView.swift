//
//  Extension+UICollectionView.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 25/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    class func createView(with backgroundColor: UIColor? = nil) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0), collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        if backgroundColor != nil {
            collectionView.backgroundColor = backgroundColor
        } else {
            collectionView.backgroundColor = .white
        }
        return collectionView
    }
}
