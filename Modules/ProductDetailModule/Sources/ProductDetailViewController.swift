//
//  ProductDetailViewController.swift
//  ProductDetail
//
//  Created by Yasin Akbas on 10.03.2025.
//

import UIKit

protocol ProductDetailViewInterface: AnyObject {
    func prepareUI()
}

class ProductDetailViewController: UIViewController {
    var presenter: ProductDetailPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: - ProductDetailViewInterface
extension ProductDetailViewController: ProductDetailViewInterface { 
    func prepareUI() { 
    
    }
}
