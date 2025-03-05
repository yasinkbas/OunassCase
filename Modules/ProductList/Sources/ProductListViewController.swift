//
//  ProductListViewController.swift
//  ProductList
//
//  Created by Yasin Akbas on 5.03.2025.
//

import UIKit

protocol ProductListViewInterface: AnyObject {
    func prepareUI()
}

class ProductListViewController: UIViewController {
    var presenter: ProductListPresenterInterface!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await presenter.viewDidLoad()
        }
        view.backgroundColor = .purple
        title = "Product List"
    }
}

// MARK: - ProductListViewInterface
extension ProductListViewController: ProductListViewInterface { 
    func prepareUI() { 
    
    }
}
