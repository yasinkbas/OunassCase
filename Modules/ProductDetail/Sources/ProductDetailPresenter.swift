//
//  ProductDetailPresenter.swift
//  ProductDetail
//
//  Created by Yasin Akbas on 10.03.2025.
//

import Foundation

protocol ProductDetailPresenterInterface: AnyObject {
    func viewDidLoad()
}

class ProductDetailPresenter {
    private weak var view: ProductDetailViewInterface?
    private let router: ProductDetailRouterInterface
    private let interactor: ProductDetailInteractorInterface

    init(
        view: ProductDetailViewInterface,
        router: ProductDetailRouterInterface,
        interactor: ProductDetailInteractorInterface
    ) {
        
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - ProductDetailPresenterInterface
extension ProductDetailPresenter: ProductDetailPresenterInterface {
    func viewDidLoad() {

    }
}

// MARK: - ProductDetailInteractorOutput
extension ProductDetailPresenter: ProductDetailInteractorOutput { 
    
}
