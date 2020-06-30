//
//  AppCoordinator.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 25/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        showTabBar()
    }
    
    func showTabBar() {
        let tabBarCoordinator = TabBarCoordinator(window: window)
        tabBarCoordinator.start()
    }
}
