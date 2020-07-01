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
import GoogleSignIn

protocol LoginViewProtocol: AnyObject {
    func didTapSignInButton(username: String, password: String)
    func didTapGoogleSignOutButton()
}

class LoginView: UIView, NibLoadableView {
    var view: UIView?
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rememberMeButton: UIButton!
    
    lazy var fbButton: FBLoginButton = {
        return FBLoginButton()
    }()
    
    lazy var googleSignInButton: GIDSignInButton = {
        let signInButton = GIDSignInButton()
        signInButton.style = GIDSignInButtonStyle.wide
        return signInButton
    }()
    
    lazy var googleSignOutButton: UIButton = {
        let signOutButton = UIButton()
        signOutButton.layer.cornerRadius = 3.0
        signOutButton.setTitle("Sign Out From Google", for: .normal)
        signOutButton.setTitleColor(.white, for: .normal)
        signOutButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        signOutButton.backgroundColor = .googleRed
        signOutButton.addTarget(self, action: #selector(googleSignOutButtonTapped(_:)), for: .touchUpInside)
        signOutButton.isHidden = true
        return signOutButton
    }()
    
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
        setupGoogleSignOutButton()
        setupGoogleSignInButton()
    }
    
    func setupFBButton() {
        addSubview(fbButton)
        
        fbButton.snp.makeConstraints { (make) in
            make.top.equalTo(rememberMeButton.snp.bottom).offset(32)
            make.centerX.equalTo(self)
            make.height.equalTo(30)
        }
        setNeedsUpdateConstraints()
        
        NotificationCenter.default.addObserver(forName: .AccessTokenDidChange, object: nil, queue: OperationQueue.main) { (notification) in
            print("FB Access Token: \(String(describing: AccessToken.current?.tokenString))")
        }
    }
    
    func setupGoogleSignOutButton() {
        addSubview(googleSignOutButton)
        
        googleSignOutButton.snp.makeConstraints { (make) in
            make.top.equalTo(rememberMeButton.snp.bottom).offset(78)
            make.centerX.equalTo(self)
            make.height.equalTo(28)
            make.width.equalTo(183)
        }
        setNeedsUpdateConstraints()
    }
    
    func setupGoogleSignInButton() {
        addSubview(googleSignInButton)
        
        googleSignInButton.snp.makeConstraints { (make) in
            make.top.equalTo(rememberMeButton.snp.bottom).offset(78)
            make.centerX.equalTo(self)
            make.height.equalTo(30)
        }
        setNeedsUpdateConstraints()
    }
    
    @IBAction func didTapSignInButton(_ sender: Any) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        delegate?.didTapSignInButton(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    @IBAction func didTapRememberMeButton(_ sender: Any) {
        rememberMeButton.isSelected = !rememberMeButton.isSelected
    }
    
    @objc func googleSignOutButtonTapped(_ sender: UIButton) {
        delegate?.didTapGoogleSignOutButton()
    }
    
    func updateGoogleButton() {
        if let user = GIDSignIn.sharedInstance()?.currentUser, let username = user.profile.givenName {
            usernameTextField.text = username
            googleSignInButton.isHidden = true
            googleSignOutButton.isHidden = false
        } else {
            usernameTextField.text = ""
            googleSignInButton.isHidden = false
            googleSignOutButton.isHidden = true
        }
    }
}
