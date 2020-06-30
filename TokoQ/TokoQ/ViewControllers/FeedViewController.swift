//
//  FeedViewController.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 25/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import UIKit
import SnapKit

class FeedViewController: UIViewController, Coordinated {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 40.0))
        label.text = "Coming soon"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    var coordinator: FeedCoordinator?
    
    func getCoordinator() -> Coordinator? {
        return coordinator
    }
    
    func setCoordinator(_ coordinator: Coordinator) {
        self.coordinator = coordinator as? FeedCoordinator
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavBar()
    }
    
    func setupView() {
        view.backgroundColor = .tokoQBgColor
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(view)
        }
        
        view.setNeedsUpdateConstraints()
    }
}
