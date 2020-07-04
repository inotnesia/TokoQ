//
//  Extension+UIViewController.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 25/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import UIKit

extension UIViewController {
        
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
