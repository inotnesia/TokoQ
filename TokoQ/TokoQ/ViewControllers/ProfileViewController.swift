//
//  ProfileViewController.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 25/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController, Coordinated {
    
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
    
    let disposeBag = DisposeBag()
    
    var coordinator: ProfileCoordinator?
    
    func getCoordinator() -> Coordinator? {
        return coordinator
    }
    
    func setCoordinator(_ coordinator: Coordinator) {
        self.coordinator = coordinator as? ProfileCoordinator
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        setupView()
        setupNavBar()
        setupBackButton()
        setupCellConfiguration()
        setupCellTapHandling()
    }
    
    func setupView() {
        view.backgroundColor = .tokoQBgColor
        tableView.constrainEdges(to: view)
        view.setNeedsUpdateConstraints()
    }
    
    func setupCellConfiguration() {
        PurchasedHistory.sharedPurchased.purchasedProducts
            .bind(to: tableView
                .rx
                .items(cellIdentifier: String(describing: ProductListCell.self),
                       cellType: ProductListCell.self)) { row, productViewModel, cell in
                        cell.configure(viewModel: productViewModel)
                        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            }.disposed(by: disposeBag)
    }
    
    func setupCellTapHandling() {
        tableView
            .rx
            .modelSelected(ProductViewModel.self)
            .subscribe(onNext: { [unowned self] productViewModel in
                if let selectedRowIndexPath = self.tableView.indexPathForSelectedRow {
                    self.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
                    self.coordinator?.showProductDetail(productViewModel)
                }
            })
            .disposed(by: disposeBag)
    }
}
