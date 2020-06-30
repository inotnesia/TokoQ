//
//  FeedCoordinator.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 25/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import UIKit

class FeedCoordinator: DefaultCoordinator {
    
    internal var viewController: FeedViewController?
    internal var navigationController: UINavigationController?
    
    init() {
        self.navigationController = UINavigationController(rootViewController: FeedViewController())
        if let feedViewController = self.navigationController?.topViewController {
            self.viewController = feedViewController as? FeedViewController
        }
    }
    
    func start() {
        viewController?.coordinator = self
        viewController?.title = "Feed"
        viewController?.tabBarItem = UITabBarItem(title: "Feed", image: #imageLiteral(resourceName: "feed"), selectedImage: #imageLiteral(resourceName: "feed"))
    }
}
