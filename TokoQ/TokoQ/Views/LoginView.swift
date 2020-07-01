//
//  LoginView.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 30/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import UIKit
import SnapKit
import FBSDKLoginKit

protocol LoginViewProtocol: AnyObject {
    func didTapSignInButton(username: String, password: String)
}

class LoginView: UIView, NibLoadableView {
    var view: UIView?
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rememberMeButton: UIButton!
    
    weak var delegate: LoginViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure() {
        rememberMeButton.setImage(#imageLiteral(resourceName: "unchecked").withRenderingMode(.alwaysTemplate), for: .normal)
        rememberMeButton.setImage(#imageLiteral(resourceName: "checked").withRenderingMode(.alwaysTemplate), for: .selected)
        rememberMeButton.tintColor = .tokoQPrimaryColor
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.tokoQPrimaryColor.cgColor
        clipsToBounds = true
        
        setupFBButton()
    }
    
    func setupFBButton() {
        let loginButton = FBLoginButton()
        addSubview(loginButton)
        
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(rememberMeButton.snp.bottom).offset(32)
            make.centerX.equalTo(self)
            make.height.equalTo(30)
        }
        setNeedsUpdateConstraints()
        
        NotificationCenter.default.addObserver(forName: .AccessTokenDidChange, object: nil, queue: OperationQueue.main) { (notification) in
            print("FB Access Token: \(String(describing: AccessToken.current?.tokenString))")
        }
    }
    
    @IBAction func didTapSignInButton(_ sender: Any) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        delegate?.didTapSignInButton(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    @IBAction func didTapRememberMeButton(_ sender: Any) {
        rememberMeButton.isSelected = !rememberMeButton.isSelected
    }
}
