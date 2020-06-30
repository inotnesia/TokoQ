//
//  ProfileViewController.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 25/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, Coordinated {
    
    var coordinator: ProfileCoordinator?
    
    func getCoordinator() -> Coordinator? {
        return coordinator
    }
    
    func setCoordinator(_ coordinator: Coordinator) {
        self.coordinator = coordinator as? ProfileCoordinator
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavBar()
        setupBackButton()
    }
    
    func setupView() {
        view.backgroundColor = .tokoQBgColor
    }
}
