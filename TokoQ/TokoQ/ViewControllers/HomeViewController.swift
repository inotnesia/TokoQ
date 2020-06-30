//
//  HomeViewController.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 25/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController, Coordinated {
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.createView(with: .tokoQBgColor)
        collectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: String(describing: CategoriesCell.self))
        collectionView.register(UINib(nibName: String(describing: ProductCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ProductCell.self))
        return collectionView
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    lazy var infoLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: collectionView.frame.width - 32, height: 40))
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.center = view.center
        return label
    }()
    
    let productService: ProductService = ProductService.shared
    var products: [Product] = []
    var categories: [Category] = []
    
    lazy var homeViewModel: HomeViewModel = {
        let viewModel = HomeViewModel(productService: ProductService.shared)
        return viewModel
    }()
    
    let disposeBag = DisposeBag()
    
    var coordinator: HomeCoordinator?
    
    func getCoordinator() -> Coordinator? {
        return coordinator
    }
    
    func setCoordinator(_ coordinator: Coordinator) {
        self.coordinator = coordinator as? HomeCoordinator
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        view.addSubview(infoLabel)
        setupView()
        setupNavBar()
        setupSearchButton()
        setupBackButton()
        
        homeViewModel.products.drive(onNext: {[unowned self] (_) in
            self.collectionView.reloadData()
        }).disposed(by: disposeBag)
        
        homeViewModel.categories.drive(onNext: {[unowned self] (_) in
            self.collectionView.reloadData()
        }).disposed(by: disposeBag)
        
        homeViewModel.isFetching.drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        homeViewModel.error.drive(onNext: {[unowned self] (error) in
            self.infoLabel.isHidden = !self.homeViewModel.hasError
            self.infoLabel.text = error
        }).disposed(by: disposeBag)
    }
    
    func setupView() {
        collectionView.constrainEdges(to: view)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        view.setNeedsUpdateConstraints()
    }
    
    func setupSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
    }
    
    @objc func searchTapped() {
        //coordinator?.showProductSearch(homeViewModel.viewModelForProducts())
        coordinator?.showLogin()
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1 : homeViewModel.numberOfProducts
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoriesCell.self), for: indexPath) as? CategoriesCell else { return UICollectionViewCell() }
            cell.categories = homeViewModel.viewModelForCategories()
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProductCell.self), for: indexPath) as? ProductCell else { return UICollectionViewCell() }
            if let viewModel = homeViewModel.viewModelForProduct(at: indexPath.row) {
                cell.configure(viewModel: viewModel)
            }
            return cell
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width, height: 86)
        } else {
            return CGSize(width: collectionView.frame.width - 32, height: 150)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        } else {
            return UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if let viewModel = homeViewModel.viewModelForProduct(at: indexPath.row) {
                coordinator?.showProductDetail(viewModel)
            }
        }
    }
}
