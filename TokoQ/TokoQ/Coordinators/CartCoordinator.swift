//
//  CartCoordinator.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 25/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import UIKit

class CartCoordinator: DefaultCoordinator {
    
    internal var viewController: CartViewController?
    internal var navigationController: UINavigationController?
    
    init() {
        self.navigationController = UINavigationController(rootViewController: CartViewController())
        if let cartViewController = self.navigationController?.topViewController {
            self.viewController = cartViewController as? CartViewController
        }
    }
    
    func start() {
        viewController?.coordinator = self
        viewController?.title = "Cart"
        viewController?.tabBarItem = UITabBarItem(title: "Cart", image: #imageLiteral(resourceName: "cart"), selectedImage: #imageLiteral(resourceName: "cart"))
    }
}
