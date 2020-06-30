//
//  DetailView.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 29/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    func didTapShareButton(_ url: URL)
    func didTapBuyButton()
}

class DetailView: UIView, NibLoadableView {
    var view: UIView?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    weak var delegate: DetailViewProtocol?
    var imageUrl: URL?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(viewModel: ProductViewModel) {
        imageUrl = viewModel.imageUrl
        imageView.kf.setImage(with: viewModel.imageUrl)
        titleLabel.text = viewModel.title
        descLabel.text = viewModel.description
        priceLabel.text = viewModel.price
        
        likeButton.setImage(#imageLiteral(resourceName: "heartempty").withRenderingMode(.alwaysTemplate), for: .normal)
        likeButton.setImage(#imageLiteral(resourceName: "heartfull").withRenderingMode(.alwaysTemplate), for: .selected)
        likeButton.tintColor = .tokoQPrimaryColor
        likeButton.isSelected = viewModel.isLoved
        
        shareButton.setImage(#imageLiteral(resourceName: "shareempty").withRenderingMode(.alwaysTemplate), for: .normal)
        shareButton.setImage(#imageLiteral(resourceName: "sharefull").withRenderingMode(.alwaysTemplate), for: .highlighted)
        shareButton.tintColor = .tokoQPrimaryColor
    }
    
    @IBAction func didTapShareButton(_ sender: Any) {
        if let url = imageUrl {
            delegate?.didTapShareButton(url)
        }
    }
    
    @IBAction func didTapLikeButton(_ sender: Any) {
        likeButton.isSelected = !likeButton.isSelected
    }
    
    @IBAction func didTapBuyButton(_ sender: Any) {
        delegate?.didTapBuyButton()
    }
}
