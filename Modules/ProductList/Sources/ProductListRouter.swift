//
//  ProductListRouter.swift
//  ProductList
//
//  Created by Yasin Akbas on 5.03.2025.
//

import UIKit

protocol ProductListRouterInterface: AnyObject {
    
}

final class ProductListRouter {
    private weak var navigationController: UINavigationController?
    
    init(with navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    static func createModule(using navigationController: UINavigationController? = nil) -> ProductListViewController { 
        let view = ProductListViewController()
        let interactor = ProductListInteractor()
        let router = ProductListRouter(with: navigationController)
        let presenter = ProductListPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
}

// MARK: - ProductListRouterInterface
extension ProductListRouter: ProductListRouterInterface { 
    
}

