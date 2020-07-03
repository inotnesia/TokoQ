//
//  HomeViewModel.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 29/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    private let productService: ProductServiceProtocol
    private let disposeBag = DisposeBag()
    private let _products = BehaviorRelay<[Product]>(value: [])
    private let _categories = BehaviorRelay<[Category]>(value: [])
    private let _isFetching = BehaviorRelay<Bool>(value: false)
    private let _error = BehaviorRelay<String?>(value: nil)
    
    var isFetching: Driver<Bool> {
        return _isFetching.asDriver()
    }
    
    var products: Driver<[Product]> {
        return _products.asDriver()
    }
    
    var categories: Driver<[Category]> {
        return _categories.asDriver()
    }
    
    var error: Driver<String?> {
        return _error.asDriver()
    }
    
    var hasError: Bool {
        return _error.value != nil
    }
    
    var numberOfProducts: Int {
        return _products.value.count
    }
    
    var numberOfCategories: Int {
        return _categories.value.count
    }
    
    init(productService: ProductServiceProtocol) {
        self.productService = productService
        self.fetchProducts()
    }
    
    func viewModelForProduct(at index: Int) -> ProductViewModel? {
        guard index < _products.value.count else { return nil }
        return ProductViewModel(product: _products.value[index])
    }
    
    func viewModelForProducts() -> [ProductViewModel] {
        var productsViewModel: [ProductViewModel] = []
        for product in _products.value {
            productsViewModel.append(ProductViewModel(product: product))
        }
        return productsViewModel
    }
    
    func viewModelForCategories() -> [CategoryViewModel] {
        var categoriesViewModel: [CategoryViewModel] = []
        for category in _categories.value {
            categoriesViewModel.append(CategoryViewModel(category: category))
        }
        return categoriesViewModel
    }
    
    func fetchProducts() {
        self._products.accept([])
        self._categories.accept([])
        self._isFetching.accept(true)
        self._error.accept(nil)
        productService.fetchProduct(successHandler: {[unowned self] (response) in
            self._isFetching.accept(false)
            self._products.accept(response.data.productPromo)
            self._categories.accept(response.data.category)
        }) { [unowned self] (error) in
            self._isFetching.accept(false)
            self._error.accept(error.localizedDescription)
        }
    }
}
