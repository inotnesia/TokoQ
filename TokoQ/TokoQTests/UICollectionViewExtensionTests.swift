//
//  UICollectionViewExtensionTests.swift
//  TokoQTests
//
//  Created by Tony Hadisiswanto on 02/07/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import XCTest
@testable import TokoQ

class UICollectionViewExtensionTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testCreateViewWithBgColor() {
        let collectionView = UICollectionView.createView(with: .red)
        XCTAssertEqual(collectionView.backgroundColor, UIColor.red, "Color assignment to UICollectionView is wrong")
    }
    
    func testCreateViewWithoutBgColor() {
        let collectionView = UICollectionView.createView(with: nil)
        XCTAssertEqual(collectionView.backgroundColor, UIColor.white, "Default color assignment to UICollectionView is wrong")
    }

}
