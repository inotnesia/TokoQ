//
//  SearchViewModel.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 30/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel {
    private let disposeBag = DisposeBag()
    private var productList: [ProductViewModel] = []
    
    init(query: Driver<String>, productList: [ProductViewModel]) {
        self.productList = productList
        query
            .distinctUntilChanged()
            .drive(onNext: { [weak self] (queryString) in
                self?.searchProduct(query: queryString)
                if queryString.isEmpty {
                    self?._products.accept([])
                    self?._info.accept("")
                }
            }).disposed(by: disposeBag)
    }
    
    private let _products = BehaviorRelay<[ProductViewModel]>(value: [])
    private let _info = BehaviorRelay<String?>(value: nil)
    
    var products: Driver<[ProductViewModel]> {
        return _products.asDriver()
    }
    
    var info: Driver<String?> {
        return _info.asDriver()
    }
    
    var hasInfo: Bool {
        return _info.value != nil
    }
    
    var numberOfProducts: Int {
        return _products.value.count
    }
    
    func viewModelForProduct(at index: Int) -> ProductViewModel? {
        guard index < _products.value.count else { return nil }
        return _products.value[index]
    }
    
    private func searchProduct(query: String?) {
        guard let query = query, !query.isEmpty else { return }
        self._products.accept([])
        self._info.accept(nil)
        
        var result: [ProductViewModel] = []
        for aProduct in productList where aProduct.title.lowercased().contains(query.lowercased()) {
            result.append(aProduct)
        }
        
        if result.isEmpty {
            self._info.accept("No result for \(query)")
        } else {
            self._products.accept(result)
        }
    }
}
