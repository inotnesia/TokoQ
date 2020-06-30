//
//  Extension+URL.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 26/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import Foundation

extension URL {
    init(staticString string: StaticString) {
        guard let url = URL(string: "\(string)") else {
            preconditionFailure("Invalid static URL string: \(string)")
        }
        
        self = url
    }
}
