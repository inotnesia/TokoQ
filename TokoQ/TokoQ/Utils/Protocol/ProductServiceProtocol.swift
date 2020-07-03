//
//  ProductServiceProtocol.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 03/07/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import Foundation

protocol ProductServiceProtocol: AnyObject {
    func fetchProduct(successHandler: @escaping (_ response: ProductResponse) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
}
