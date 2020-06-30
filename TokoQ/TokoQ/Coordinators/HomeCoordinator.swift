//
//  HomeCoordinator.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 25/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import UIKit

class HomeCoordinator: DefaultCoordinator {
    
    internal var viewController: HomeViewController?
    internal var navigationController: UINavigationController?
    
    init() {
        self.navigationController = UINavigationController(rootViewController: HomeViewController())
        if let homeViewController = self.navigationController?.topViewController {
            self.viewController = homeViewController as? HomeViewController
        }
    }
    
    func start() {
        viewController?.coordinator = self
        viewController?.title = "Home"
        viewController?.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "home"), selectedImage: #imageLiteral(resourceName: "home"))
        
        DispatchQueue.main.async {
            self.showLogin()
        }
    }
    
    func showProductDetail(_ viewModel: ProductViewModel) {
        let productDetailCoordinator = ProductDetailCoordinator(navigationController, productViewModel: viewModel)
        productDetailCoordinator.start()
        navigationController?.pushViewController(productDetailCoordinator.viewController ?? UIViewController(), animated: true)
    }
    
    func showProductSearch(_ products: [ProductViewModel]) {
        let searchCoordinator = SearchCoordinator(navigationController, products: products)
        searchCoordinator.start()
        navigationController?.pushViewController(searchCoordinator.viewController ?? UIViewController(), animated: true)
    }
    
    func showLogin() {
        if let navigation = navigationController {
            let coordinator = SignInCoordinator(navigationController: navigation, destinationNavigationController: nil)
            coordinator.start()
        }
    }
}
