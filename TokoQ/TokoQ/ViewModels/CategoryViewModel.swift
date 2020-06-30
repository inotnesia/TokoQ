//
//  CategoryViewModel.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 27/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import Foundation

struct CategoryViewModel {
    private var category: Category
    
    init(category: Category) {
        self.category = category
    }
    
    var title: String {
        return category.name ?? ""
    }
    
    var imageUrl: URL {
        if let urlString = category.imageUrl, let url = URL(string: urlString) {
            return url
        } else {
            return URL(staticString: "https://via.placeholder.com/50")
        }
    }
}
