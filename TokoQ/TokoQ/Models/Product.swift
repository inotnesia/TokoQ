//
//  Product.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 26/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import Foundation

public struct ProductResponse: Codable {
    public let data: Data
}

public struct Data: Codable {
    public let category: [Category]
    public let productPromo: [Product]
}

public struct Category: Codable {
    public let id: Int
    public var imageUrl: String?
    public let name: String?
}

public struct Product: Codable {
    public let id: String?
    public var imageUrl: String?
    public let title: String?
    public let description: String?
    public let price: String?
    public let loved: Int
    public var isLoved: Bool {
        return loved == 1 ? true : false
    }
}
