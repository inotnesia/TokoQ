//
//  MockProductServiceProtocol.swift
//  TokoQTests
//
//  Created by Tony Hadisiswanto on 03/07/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

@testable import TokoQ
import Foundation

class MockProductServiceProtocol: ProductServiceProtocol {
    var isFetchProductInvoked = false
    
    static let stubCategories = [
        Category(id: 1, imageUrl: "https://via.placeholder.com/50", name: "Baju"),
        Category(id: 2, imageUrl: "https://via.placeholder.com/75", name: "Celana")
    ]
    
    static let stubProducts = [
        Product(id: "1", imageUrl: "https://via.placeholder.com/110", title: "Nitendo Switch", description: "Lorem ipsum dolor sit amet 1", price: "$340", loved: 1),
        Product(id: "2", imageUrl: "https://via.placeholder.com/120", title: "Nitendo DS Lite", description: "Lorem ipsum dolor sit amet 2", price: "$70", loved: 0)
    ]
    
    static let stubData = Data(category: stubCategories, productPromo: stubProducts)
    static let stubProductResponse = ProductResponse(data: stubData)
    
    func fetchProduct(successHandler: @escaping (_ response: ProductResponse) -> Void, errorHandler: @escaping(_ error: Error) -> Void) {
        isFetchProductInvoked = true
        successHandler(MockProductServiceProtocol.stubProductResponse)
    }
}
