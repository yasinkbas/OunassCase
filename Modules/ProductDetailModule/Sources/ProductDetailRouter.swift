//
//  ProductDetailRouter.swift
//  ProductDetail
//
//  Created by Yasin Akbas on 10.03.2025.
//

import UIKit
import DependencyManagerKit

protocol ProductDetailRouterInterface: AnyObject {
    func dismiss()
}

final class ProductDetailRouter {
    private weak var view: UIViewController?
    @Dependency private var productListModule: ProductListModuleInterface
    
    init(view: UIViewController) {
        self.view = view
    }

    static func createModule(using navigationController: UINavigationController? = nil, with arguments: ProductDetailArguments) -> ProductDetailViewController {
        let view = ProductDetailViewController()
        let interactor = ProductDetailInteractor()
        let router = ProductDetailRouter(view: view)
        let presenter = ProductDetailPresenter(view: view, router: router, interactor: interactor, arguments: arguments)
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
    
    func dismiss() {
        view?.dismiss(animated: true)
    }
}

// MARK: - ProductDetailRouterInterface
extension ProductDetailRouter: ProductDetailRouterInterface { 
    
}

