//
//  CategoryViewModelTest.swift
//  TokoQTests
//
//  Created by Tony Hadisiswanto on 02/07/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import XCTest
@testable import TokoQ

class CategoryViewModelTest: XCTestCase {
    
    var sut: CategoryViewModel?
    let fakeCategory = Category(id: 1, imageUrl: "https://via.placeholder.com/50", name: "Placeholder")
    
    override func setUp() {
        super.setUp()
        sut = CategoryViewModel(category: fakeCategory)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testTitle() {
        let title = "Placeholder"
        XCTAssertEqual(sut?.title, title, "Title is ok")
    }
    
    func testImageUrl() {
        if let imageUrl = URL(string: "https://via.placeholder.com/50") {
            XCTAssertEqual(sut?.imageUrl, imageUrl, "Image URL is ok")
        }
    }
}
