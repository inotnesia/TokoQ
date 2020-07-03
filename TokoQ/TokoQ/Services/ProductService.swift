//
//  ProductService.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 26/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import Foundation

public enum ProductError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
}

public class ProductService: ProductServiceProtocol {
    public static let shared = ProductService()
    private init() {}
    private let baseAPI = "https://private-4639ce-ecommerce56.apiary-mock.com/home"
    private let urlSession = URLSession.shared
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    public func fetchProduct(successHandler: @escaping (_ response: ProductResponse) -> Void, errorHandler: @escaping(_ error: Error) -> Void) {
        guard let url = URL(string: "\(baseAPI)") else {
            handleError(errorHandler: errorHandler, error: ProductError.invalidEndpoint)
            return
        }
        
        urlSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.handleError(errorHandler: errorHandler, error: ProductError.apiError)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.handleError(errorHandler: errorHandler, error: ProductError.invalidResponse)
                return
            }
            
            guard let data = data else {
                self.handleError(errorHandler: errorHandler, error: ProductError.noData)
                return
            }
            
            do {
                let productResponse = try self.jsonDecoder.decode([ProductResponse].self, from: data)
                DispatchQueue.main.async {
                    if let data = productResponse.first {
                        successHandler(data)
                    }
                }
            } catch {
                self.handleError(errorHandler: errorHandler, error: ProductError.serializationError)
            }
        }.resume()
    }
    
    private func handleError(errorHandler: @escaping(_ error: Error) -> Void, error: Error) {
        DispatchQueue.main.async {
            errorHandler(error)
        }
    }
}
