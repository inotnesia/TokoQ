//
//  SearchViewController.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 30/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SearchViewController: UIViewController, Coordinated {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = 66
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
        tableView.register(UINib(nibName: String(describing: ProductListCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ProductListCell.self))
        return tableView
    }()
    
    lazy var infoLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.center = view.center
        return label
    }()
    
    var searchViewModel: SearchViewModel?
    let disposeBag = DisposeBag()
    
    var coordinator: SearchCoordinator?
    
    func getCoordinator() -> Coordinator? {
        return coordinator
    }
    
    func setCoordinator(_ coordinator: Coordinator) {
        self.coordinator = coordinator as? SearchCoordinator
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search Products"
        view.addSubview(tableView)
        view.addSubview(infoLabel)
        setupNavBar()
        setupBackButton()
        setupSearchView()
        
        if let searchBar = self.navigationItem.searchController?.searchBar {
            searchViewModel = SearchViewModel(query: searchBar.rx.text.orEmpty.asDriver(), productList: coordinator?.products ?? [])
            
            searchViewModel?.products.drive(onNext: {[unowned self] (_) in
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
            
            searchViewModel?.info.drive(onNext: {[unowned self] (info) in
                if let hasInfo = self.searchViewModel?.hasInfo {
                    self.infoLabel.isHidden = !hasInfo
                }
                self.infoLabel.text = info
            }).disposed(by: disposeBag)
            
            searchBar.rx.searchButtonClicked
                .asDriver(onErrorJustReturn: ())
                .drive(onNext: { [unowned searchBar] in
                    searchBar.resignFirstResponder()
                }).disposed(by: disposeBag)
            
            searchBar.rx.cancelButtonClicked
                .asDriver(onErrorJustReturn: ())
                .drive(onNext: { [unowned searchBar] in
                    searchBar.resignFirstResponder()
                }).disposed(by: disposeBag)
        }
        
        setupView()
    }
    
    func setupView() {
        tableView.constrainEdges(to: view)
        view.backgroundColor = .white
        view.setNeedsUpdateConstraints()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupSearchView() {
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        self.definesPresentationContext = true
        navigationItem.searchController?.dimsBackgroundDuringPresentation = false
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = true
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        navigationItem.searchController?.searchBar.setImage(#imageLiteral(resourceName: "search").withRenderingMode(.alwaysTemplate), for: .search, state: .normal)
        navigationItem.searchController?.searchBar.setImage(#imageLiteral(resourceName: "cancel").withRenderingMode(.alwaysTemplate), for: .clear, state: .normal)
        navigationItem.searchController?.searchBar.tintColor = .white
        navigationItem.searchController?.searchBar.searchBarStyle = .minimal
        
        navigationItem.searchController?.searchBar.sizeToFit()
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension SearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel?.numberOfProducts ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ProductListCell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductListCell.self)) as? ProductListCell else { return UITableViewCell() }
        if let viewModel = searchViewModel?.viewModelForProduct(at: indexPath.row) {
            cell.configure(viewModel: viewModel)
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        }
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let viewModel = searchViewModel?.viewModelForProduct(at: indexPath.row) {
            coordinator?.showProductDetail(viewModel)
        }
    }
}
