//
//  ProductListCell.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 30/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import UIKit

class ProductListCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(viewModel: ProductViewModel) {
        titleLabel.text = viewModel.title
        priceLabel.text = viewModel.price
        productImageView.kf.setImage(with: viewModel.imageUrl)
    }
}
