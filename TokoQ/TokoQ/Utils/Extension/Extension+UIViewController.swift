//
//  Extension+UIViewController.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 25/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import UIKit

extension UIViewController {
    
//    func setupLogoView() {
//        guard let navController = navigationController else { return }
//        let logoX = (navController.navigationBar.frame.size.width - Constant.shared.logoWidth) / 2
//        let logoY = (navController.navigationBar.frame.size.height - Constant.shared.logoHeight) / 2
//        let logo = LogoView(frame: CGRect(x: logoX, y: logoY, width: Constant.shared.logoWidth, height: Constant.shared.logoHeight))
//        let leftItem = UIBarButtonItem(customView: logo)
//        leftItem.isEnabled = false
//        navigationItem.leftBarButtonItem = leftItem
//    }
    
    func setupNavBar() {
        navigationController?.navigationBar.barTintColor = UIColor.tokoQPrimaryColor
        navigationController?.navigationBar.isTranslucent = false
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = .white
    }
    
    func setupBackButton() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
