//
//  ProductViewModel.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 26/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import Foundation

struct ProductViewModel: Equatable {
    static func == (lhs: ProductViewModel, rhs: ProductViewModel) -> Bool {
        return lhs.title == rhs.title && lhs.imageUrl == rhs.imageUrl && lhs.isLoved == rhs.isLoved && lhs.description == rhs.description && lhs.price == rhs.price
    }
    
    private var product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var title: String {
        return product.title ?? ""
    }
    
    var imageUrl: URL {
        if let urlString = product.imageUrl, let url = URL(string: urlString) {
            return url
        } else {
            return URL(staticString: "https://via.placeholder.com/320x100")
        }
    }
    
    var isLoved: Bool {
        return product.isLoved
    }
    
    var description: String {
        return product.description ?? ""
    }
    
    var price: String {
        return product.price ?? ""
    }
}
