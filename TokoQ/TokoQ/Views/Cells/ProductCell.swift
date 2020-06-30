//
//  ProductCell.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 26/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import UIKit
import Kingfisher

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loveView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(viewModel: ProductViewModel) {
        titleLabel.text = viewModel.title
        loveView.image = viewModel.isLoved ? #imageLiteral(resourceName: "heartfull") : #imageLiteral(resourceName: "heartempty")
        imageView.kf.setImage(with: viewModel.imageUrl)
        backgroundColor = .white
        layer.cornerRadius = 4
    }
}
