//
//  BasketListPresenter.swift
//  BasketListModule
//
//  Created by Yasin Akbas on 12.03.2025.
//

import Foundation
import BasketManagerKit
import CommonKit

protocol BasketListPresenterInterface: AnyObject {
    func viewDidLoad()
    func numberOfRowsInSection() -> Int
    func productName(at indexPath: IndexPath) -> String?
}

class BasketListPresenter {
    private weak var view: BasketListViewInterface?
    private let router: BasketListRouterInterface
    private let interactor: BasketListInteractorInterface
    private let basketManager: BasketManagerInterface

    init(
        view: BasketListViewInterface,
        router: BasketListRouterInterface,
        interactor: BasketListInteractorInterface,
        basketManager: BasketManagerInterface = BasketManager.shared
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.basketManager = basketManager
    }
    
    private func checkBasketIsEmpty() {
        if basketManager.getAllProducts().count == 0 {
            view?.showEmptyView()
        }
    }
}

// MARK: - BasketListPresenterInterface
extension BasketListPresenter: BasketListPresenterInterface {
    func viewDidLoad() {
        view?.prepareUI()
        view?.reloadTableView()
        checkBasketIsEmpty()
    }
    
    func numberOfRowsInSection() -> Int {
        basketManager.getAllProducts().count
    }
    
    func productName(at indexPath: IndexPath) -> String? {
        guard let product = basketManager.getAllProducts()[safe: indexPath.item] else { return nil }
        return "\(product.name) - \(product.size)"
    }
}

// MARK: - BasketListInteractorOutput
extension BasketListPresenter: BasketListInteractorOutput { 
    
}
