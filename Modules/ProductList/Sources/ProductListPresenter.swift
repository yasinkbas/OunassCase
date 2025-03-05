//
//  ProductListPresenter.swift
//  ProductList
//
//  Created by Yasin Akbas on 5.03.2025.
//

import Foundation

protocol ProductListPresenterInterface: AnyObject {
    func viewDidLoad() async
}

class ProductListPresenter {
    private weak var view: ProductListViewInterface?
    private let router: ProductListRouterInterface
    private let interactor: ProductListInteractorInterface
    
    private var productListResponse: ProductListResponse?

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
    func viewDidLoad() async {
        let data = await interactor.fetchProducts()
        print("--> data \(data?.result?.pageTitle)")
    }
}

// MARK: - ProductListInteractorOutput
extension ProductListPresenter: ProductListInteractorOutput {
    func handleRequestError(error: any Error) {
        print("--> error \(error)")
    }
}
