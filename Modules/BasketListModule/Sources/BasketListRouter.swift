//
//  BasketListRouter.swift
//  BasketListModule
//
//  Created by Yasin Akbas on 12.03.2025.
//

import UIKit
import BasketManagerKit
import DependencyManagerKit

protocol BasketListRouterInterface: AnyObject {
    
}

final class BasketListRouter {
    private weak var navigationController: UINavigationController?
    
    init(with navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    static func createModule(using navigationController: UINavigationController? = nil) -> BasketListViewController { 
        let view = BasketListViewController()
        let interactor = BasketListInteractor()
        let router = BasketListRouter(with: navigationController)
        let presenter = BasketListPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
}

// MARK: - BasketListRouterInterface
extension BasketListRouter: BasketListRouterInterface {}

