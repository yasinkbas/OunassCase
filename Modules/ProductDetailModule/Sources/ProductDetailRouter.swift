//
//  ProductDetailRouter.swift
//  ProductDetail
//
//  Created by Yasin Akbas on 10.03.2025.
//

import UIKit

protocol ProductDetailRouterInterface: AnyObject {
    
}

final class ProductDetailRouter {
    private weak var navigationController: UINavigationController?
    
    init(with navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    static func createModule(using navigationController: UINavigationController? = nil) -> ProductDetailViewController { 
        let view = ProductDetailViewController()
        let interactor = ProductDetailInteractor()
        let router = ProductDetailRouter(with: navigationController)
        let presenter = ProductDetailPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
}

// MARK: - ProductDetailRouterInterface
extension ProductDetailRouter: ProductDetailRouterInterface { 
    
}

