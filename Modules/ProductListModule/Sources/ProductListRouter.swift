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
    func routeToDetail(detailArguments: ProductDetailModuleArguments, transitionArguments: ProductListToDetailTransitionArguments)
}

final class ProductListRouter {
    private weak var view: UIViewController?
    
    @Dependency private var detailModule: ProductDetailModuleInterface
    private var detailTransitionDelegate: UIViewControllerTransitioningDelegate?
    
    init(with view: UIViewController?) {
        self.view = view
    }

    static func createModule(using navigationController: UINavigationController? = nil) -> ProductListViewController { 
        let view = ProductListViewController()
        let interactor = ProductListInteractor()
        let router = ProductListRouter(with: view)
        let deviceChecker: DeviceChecker = DependencyEngine.shared.read(for: DeviceCheckerInterface.self)
        let presenter = ProductListPresenter(view: view, router: router, interactor: interactor, deviceChecker: deviceChecker)
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
}

// MARK: - ProductListRouterInterface
extension ProductListRouter: ProductListRouterInterface {
    func routeToDetail(detailArguments: ProductDetailModuleArguments, transitionArguments: ProductListToDetailTransitionArguments) {
        let detailViewController = detailModule.productDetailViewController(arguments: detailArguments)
        // stored due to prevent deinitialization
        detailTransitionDelegate = ProductListTransitioningDelegate(
            selectedCellFrame: transitionArguments.selectedCellFrame,
            selectedImageView: transitionArguments.selectedImageView
        )
        detailViewController.transitioningDelegate = detailTransitionDelegate
        detailViewController.modalPresentationStyle = .fullScreen
        
        view?.present(detailViewController, animated: true)
    }    
}

