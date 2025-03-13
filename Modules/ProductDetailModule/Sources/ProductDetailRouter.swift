//
//  ProductDetailRouter.swift
//  ProductDetail
//
//  Created by Yasin Akbas on 10.03.2025.
//

import UIKit
import DependencyManagerKit

protocol ProductDetailRouterInterface: AnyObject {
    func routeToBasket()
    func dismiss()
}

final class ProductDetailRouter {
    private weak var navigationController: UINavigationController?
    @Dependency private var productListModule: ProductListModuleInterface
    @Dependency private var basketModule: BasketListModuleInterface
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    static func createModule(using navigationController: UINavigationController, with arguments: ProductDetailArguments) -> ProductDetailViewController {
        let view = ProductDetailViewController()
        let interactor = ProductDetailInteractor()
        let router = ProductDetailRouter(navigationController: navigationController)
        let presenter = ProductDetailPresenter(view: view, router: router, interactor: interactor, arguments: arguments)
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
    
    func routeToBasket() {
        guard let navigationController else { return }
        let basketListController = basketModule.basketViewController(using: navigationController)
        navigationController.pushViewController(basketListController, animated: true)
    }
    
    func dismiss() {
        navigationController?.dismiss(animated: true)
    }
}

// MARK: - ProductDetailRouterInterface
extension ProductDetailRouter: ProductDetailRouterInterface {}

