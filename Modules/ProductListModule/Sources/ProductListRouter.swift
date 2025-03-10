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
        let deviceChecker: DeviceChecker = DependencyEngine.shared.read(for: DeviceCheckerInterface.self)
        let presenter = ProductListPresenter(view: view, router: router, interactor: interactor, deviceChecker: deviceChecker)
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
}

// MARK: - ProductListRouterInterface
extension ProductListRouter: ProductListRouterInterface { 
    
}

