//
//  ProductViewModel.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 26/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import Foundation

struct ProductViewModel {
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
