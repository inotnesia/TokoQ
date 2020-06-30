//
//  PurchasedHistory.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 30/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class PurchasedHistory {
    static let sharedPurchased = PurchasedHistory()
    let purchasedProducts: BehaviorRelay<[ProductViewModel]> = BehaviorRelay(value: [])
}
