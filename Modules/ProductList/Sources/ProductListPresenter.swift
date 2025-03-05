//
//  ProductListPresenter.swift
//  ProductList
//
//  Created by Yasin Akbas on 5.03.2025.
//

import Foundation

protocol ProductListPresenterInterface: AnyObject {
    func viewDidLoad()
}

class ProductListPresenter {
    private weak var view: ProductListViewInterface?
    private let router: ProductListRouterInterface
    private let interactor: ProductListInteractorInterface

    init(
        view: ProductListViewInterface,
        router: ProductListRouterInterface,
        interactor: ProductListInteractorInterface
    ) {
        
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - ProductListPresenterInterface
extension ProductListPresenter: ProductListPresenterInterface {
    func viewDidLoad() {

    }
}

// MARK: - ProductListInteractorOutput
extension ProductListPresenter: ProductListInteractorOutput { 
    
}
