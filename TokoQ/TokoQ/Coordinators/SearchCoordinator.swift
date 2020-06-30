//
//  SearchCoordinator.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 30/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import UIKit

class SearchCoordinator: DefaultCoordinator {
    
    var products: [ProductViewModel] = []
    internal var viewController: SearchViewController?
    internal var navigationController: UINavigationController?
    
    init(_ navController: UINavigationController?, products: [ProductViewModel]) {
        self.navigationController = navController
        self.products = products
        self.viewController = SearchViewController()
        self.viewController?.hidesBottomBarWhenPushed = true
    }
    
    func start() {
        viewController?.coordinator = self
    }
    
    func showProductDetail(_ viewModel: ProductViewModel) {
        let productDetailCoordinator = ProductDetailCoordinator(navigationController, productViewModel: viewModel)
        productDetailCoordinator.start()
        navigationController?.pushViewController(productDetailCoordinator.viewController ?? UIViewController(), animated: true)
    }
}
