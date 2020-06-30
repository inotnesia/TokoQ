//
//  ProductDetailCoordinator.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 29/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import UIKit

class ProductDetailCoordinator: DefaultCoordinator {
    
    var productViewModel: ProductViewModel
    internal var viewController: ProductDetailViewController?
    internal var navigationController: UINavigationController?
    
    init(_ navController: UINavigationController?, productViewModel: ProductViewModel) {
        self.navigationController = navController
        self.productViewModel = productViewModel
        self.viewController = ProductDetailViewController()
        self.viewController?.hidesBottomBarWhenPushed = true
    }
    
    func start() {
        viewController?.coordinator = self
        viewController?.title = "Detail"
    }
}
