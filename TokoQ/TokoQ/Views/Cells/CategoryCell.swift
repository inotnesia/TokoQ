//
//  CategoryCell.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 27/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(viewModel: CategoryViewModel) {
        titleLabel.text = viewModel.title
        imageView.kf.setImage(with: viewModel.imageUrl)
    }
}
