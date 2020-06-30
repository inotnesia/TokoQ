//
//  SignInCoordinator.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 30/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import UIKit

class SignInCoordinator: ModalCoordinator {
    var configuration: ((SignInCoordinator.VC) -> ())?
    var navigationController: UINavigationController
    var destinationNavigationController: UINavigationController?
    internal var viewController: SignInViewController?
    
    init(navigationController: UINavigationController, destinationNavigationController: UINavigationController?) {
        self.navigationController = navigationController
        self.destinationNavigationController = destinationNavigationController
        self.viewController = SignInViewController()
        self.viewController?.coordinator = self
    }
}
