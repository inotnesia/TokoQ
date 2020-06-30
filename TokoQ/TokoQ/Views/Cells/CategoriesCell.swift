//
//  CategoriesCell.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 28/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import UIKit

class CategoriesCell: UICollectionViewCell {
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.createView(with: .clear)
        collectionView.register(UINib(nibName: String(describing: CategoryCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: CategoryCell.self))
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        return collectionView
    }()
    
    var categories = [Category]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(collectionView)
        collectionView.constrainEdges(to: self)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension CategoriesCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryCell.self), for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
        let category = categories[indexPath.row]
        let viewModel = CategoryViewModel(category: category)
        cell.configure(viewModel: viewModel)
        return cell
    }
}

extension CategoriesCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
