//
//  SignInViewController.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 30/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import UIKit
import GoogleSignIn

class SignInViewController: UIViewController, Coordinated {
    
    lazy var loginView: LoginView = {
        let view = LoginView(frame: .zero)
        return view
    }()
    
    var coordinator: SignInCoordinator?
    
    func getCoordinator() -> Coordinator? {
        return coordinator
    }
    
    func setCoordinator(_ coordinator: Coordinator) {
        self.coordinator = coordinator as? SignInCoordinator
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginView)
        setupView()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        NotificationCenter.default.addObserver(self, selector: #selector(userDidSignInGoogle(_:)), name: .signInGoogleCompleted, object: nil)
        loginView.updateGoogleButton()
    }
    
    func setupView() {
        view.backgroundColor = .tokoQBgColor
        
        loginView.delegate = self
        loginView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(self.view)
            make.height.equalTo(370)
        }
        view.setNeedsUpdateConstraints()
    }
    
    // MARK:- Notification
    @objc private func userDidSignInGoogle(_ notification: Notification) {
        loginView.updateGoogleButton()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .signInGoogleCompleted, object: nil)
    }
}

extension SignInViewController: LoginViewProtocol {
    func didTapSignInButton(username: String, password: String) {
        if username.isEmpty && password.isEmpty {
            let alert = UIAlertController(title: "Sign In Failed", message: "Username and Password are required", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            coordinator?.stop()
        }
    }
    
    func didTapGoogleSignOutButton() {
        GIDSignIn.sharedInstance()?.signOut()
        loginView.updateGoogleButton()
    }
}
