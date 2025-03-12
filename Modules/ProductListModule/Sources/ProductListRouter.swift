//
//  ProductListRouter.swift
//  ProductList
//
//  Created by Yasin Akbas on 5.03.2025.
//

import UIKit
import DependencyManagerKit
import CommonKit

protocol ProductListRouterInterface: AnyObject {
    func routeToDetail(detailArguments: ProductDetailModuleArguments)
}

final class ProductListRouter {
    private weak var navigationController: UINavigationController?
    
    @Dependency private var detailModule: ProductDetailModuleInterface
    @Dependency private static var deviceChecker: DeviceCheckerInterface
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    static func createModule(using navigationController: UINavigationController) -> ProductListViewController {
        let view = ProductListViewController()
        let interactor = ProductListInteractor()
        let router = ProductListRouter(with: navigationController)
        let presenter = ProductListPresenter(view: view, router: router, interactor: interactor, deviceChecker: deviceChecker)
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
}

// MARK: - ProductListRouterInterface
extension ProductListRouter: ProductListRouterInterface {
    func routeToDetail(detailArguments: ProductDetailModuleArguments) {
        guard let navigationController else { return }
        let detailViewController = detailModule.productDetailViewController(using: navigationController, arguments: detailArguments)
        navigationController.pushViewController(detailViewController, animated: true)
    }
}

