//
//  TabBarCoordinator.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 25/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import UIKit

class TabBarCoordinator: Coordinator {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let tabBarController = UITabBarController()
        UITabBar.appearance().tintColor = UIColor.tokoQPrimaryColor
        
        let homeCoordinator = HomeCoordinator()
        homeCoordinator.start()
        
        let feedCoordiantor = FeedCoordinator()
        feedCoordiantor.start()
        
        let cartCoordinator = CartCoordinator()
        cartCoordinator.start()
        
        let profileCoordinator = ProfileCoordinator()
        profileCoordinator.start()
        
        if let home = homeCoordinator.navigationController, let feed = feedCoordiantor.navigationController, let cart = cartCoordinator.navigationController, let profile = profileCoordinator.navigationController {
            tabBarController.setViewControllers([home, feed, cart, profile], animated: false)
        }
        
        window.rootViewController = tabBarController
    }
}
