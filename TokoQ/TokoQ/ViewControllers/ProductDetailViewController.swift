//
//  ProductDetailViewController.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 29/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController, Coordinated {
    
    lazy var detailView: DetailView = {
        let view = DetailView(frame: .zero)
        return view
    }()
    
    var coordinator: ProductDetailCoordinator?
    
    func getCoordinator() -> Coordinator? {
        return coordinator
    }
    
    func setCoordinator(_ coordinator: Coordinator) {
        self.coordinator = coordinator as? ProductDetailCoordinator
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail"
        view.addSubview(detailView)
        setupView()
    }
    
    func setupView() {
        detailView.constrainEdges(to: view)
        if let productViewModel = coordinator?.productViewModel {
            detailView.configure(viewModel: productViewModel)
            detailView.delegate = self
        }
        view.setNeedsUpdateConstraints()
    }
}

extension ProductDetailViewController: DetailViewProtocol {
    func didTapShareButton(_ url: URL) {
        let textItem = "Share Image"
        let imageItem = url
        let activityViewController = UIActivityViewController(activityItems: [textItem, imageItem], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func didTapBuyButton() {
        if let productViewModel = coordinator?.productViewModel {
            let newValue = PurchasedHistory.sharedPurchased.purchasedProducts.value + [productViewModel]
            PurchasedHistory.sharedPurchased.purchasedProducts.accept(newValue)
            
            let alert = UIAlertController(title: "Purchased Product", message: "\(productViewModel.title) has been added to the shopping cart", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
