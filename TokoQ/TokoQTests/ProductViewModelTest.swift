//
//  ProductViewModelTest.swift
//  TokoQTests
//
//  Created by Tony Hadisiswanto on 02/07/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import XCTest
@testable import TokoQ

class ProductViewModelTest: XCTestCase {
    
    var sut: ProductViewModel?
    let fakeProduct = Product(id: "1", imageUrl: "https://via.placeholder.com/50", title: "Placeholder", description: "Lorem ipsum dolor sit amet", price: "$ 10", loved: 1)
    
    override func setUp() {
        super.setUp()
        sut = ProductViewModel(product: fakeProduct)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testTitle() {
        let title = "Placeholder"
        XCTAssertEqual(sut?.title, title)
    }

    func testImageUrl() {
        if let imageUrl = URL(string: "https://via.placeholder.com/50") {
            XCTAssertEqual(sut?.imageUrl, imageUrl)
        }
    }

    func testIsLoved() {
        let isLoved = true
        XCTAssertEqual(sut?.isLoved, isLoved)
    }
    
    func testDescription() {
        let description = "Lorem ipsum dolor sit amet"
        XCTAssertEqual(sut?.description, description)
    }
    
    func testPrice() {
        let price = "$ 10"
        XCTAssertEqual(sut?.price, price)
    }
}
