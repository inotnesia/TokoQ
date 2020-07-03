//
//  HomeViewModelTests.swift
//  TokoQTests
//
//  Created by Tony Hadisiswanto on 03/07/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import XCTest
@testable import TokoQ

class HomeViewModelTests: XCTestCase {
    
    var sut: HomeViewModel?
    var mockProductService: MockProductServiceProtocol?
    
    let stubProducts = [
        Product(id: "1", imageUrl: "https://via.placeholder.com/110", title: "Nitendo Switch", description: "Lorem ipsum dolor sit amet 1", price: "$340", loved: 1),
        Product(id: "2", imageUrl: "https://via.placeholder.com/120", title: "Nitendo DS Lite", description: "Lorem ipsum dolor sit amet 2", price: "$70", loved: 0)
    ]
    let stubProduct = Product(id: "2", imageUrl: "https://via.placeholder.com/120", title: "Nitendo DS Lite", description: "Lorem ipsum dolor sit amet 2", price: "$70", loved: 0)
    
    let stubCategories = [
        Category(id: 1, imageUrl: "https://via.placeholder.com/50", name: "Baju"),
        Category(id: 2, imageUrl: "https://via.placeholder.com/75", name: "Celana"),
        Category(id: 3, imageUrl: "https://via.placeholder.com/25", name: "Jaket")
    ]
    
    override func setUp() {
        super.setUp()
        mockProductService = MockProductServiceProtocol()
        if let productService = mockProductService {
            sut = HomeViewModel(productService: productService)
        }
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testFetchProductsIsInvoked() {
        _ = sut?.fetchProducts()
        if let isFetchProduct = mockProductService?.isFetchProductInvoked {
            XCTAssertTrue(isFetchProduct)
        }
    }
    
    func testViewModelForProductAtIndex() {
        let index = 1
        guard index < stubProducts.count else { return }
        XCTAssertEqual(ProductViewModel(product: stubProducts[index]), ProductViewModel(product: stubProduct))
    }
    
    func testViewModelForProducts() {
        var productsViewModel: [ProductViewModel] = []
        for product in stubProducts {
            productsViewModel.append(ProductViewModel(product: product))
        }
        XCTAssertEqual(stubProducts.count, productsViewModel.count)
    }
    
    func testViewModelForCategories() {
        var categoriesViewModel: [CategoryViewModel] = []
        for category in stubCategories {
            categoriesViewModel.append(CategoryViewModel(category: category))
        }
        XCTAssertEqual(stubCategories.count, categoriesViewModel.count)
    }
}
