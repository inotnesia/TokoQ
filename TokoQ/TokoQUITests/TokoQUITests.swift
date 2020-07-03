//
//  TokoQUITests.swift
//  TokoQUITests
//
//  Created by Tony Hadisiswanto on 25/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import XCTest

class TokoQUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testSignInAlert() {
        let signInButton = app.buttons["Sign in"]
        let alert = app.alerts["Sign In Failed"].buttons["OK"]
        let usernameTextField = app.textFields["Username"]
        let passwordTextField = app.secureTextFields["Password"]
        
        signInButton.tap()
        
        if let usernameText = usernameTextField.value as? String, usernameText.isEmpty == false, usernameText != usernameTextField.placeholderValue {
            if let passwordText = passwordTextField.value as? String, passwordText.isEmpty == false, passwordText != passwordTextField.placeholderValue {
                XCTAssertFalse(alert.exists)
            }
        } else {
            XCTAssertTrue(alert.exists)
        }
    }

    func testGoogleSignOutButton() {
        let usernameTextField = app.textFields["Username"]
        let googleSignOutButton = app.buttons["Sign Out From Google"]
        
        if googleSignOutButton.exists {
            if let usernameText = usernameTextField.value as? String, usernameText.isEmpty == false, usernameText != usernameTextField.placeholderValue {
                XCTAssertTrue(googleSignOutButton.exists)
            } else {
                XCTAssertFalse(googleSignOutButton.exists)
            }
        } else {
            XCTAssertFalse(googleSignOutButton.exists)
        }
    }
}
