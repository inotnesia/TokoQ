//
//  ProfileCoordinator.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 25/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import UIKit

class ProfileCoordinator: DefaultCoordinator {
    
    internal var viewController: ProfileViewController?
    internal var navigationController: UINavigationController?
    
    init() {
        self.navigationController = UINavigationController(rootViewController: ProfileViewController())
        if let profileViewController = self.navigationController?.topViewController {
            self.viewController = profileViewController as? ProfileViewController
        }
    }
    
    func start() {
        viewController?.coordinator = self
        viewController?.title = "Purchased History"
        viewController?.tabBarItem = UITabBarItem(title: "Profile", image: #imageLiteral(resourceName: "profile"), selectedImage: #imageLiteral(resourceName: "profile"))
    }
    
    func showProductDetail(_ viewModel: ProductViewModel) {
        let productDetailCoordinator = ProductDetailCoordinator(navigationController, productViewModel: viewModel)
        productDetailCoordinator.start()
        navigationController?.pushViewController(productDetailCoordinator.viewController ?? UIViewController(), animated: true)
    }
}
