//
//  ProductDetailSizeSelectionRouter.swift
//  OunassCase
//
//  Created by Yasin Akbas on 12.03.2025.
//

import UIKit

protocol ProductDetailSizeSelectionRouterInterface: AnyObject {}

final class ProductDetailSizeSelectionRouter {
    static func createModule(delegate: ProductDetailSizeSelectionDelegate, arguments: ProductDetailSizeSelectionArguments) -> (ProductDetailSizeSelectionViewController, ProductDetailSizeSelectionModule) {
        let view = ProductDetailSizeSelectionViewController()
        let router = ProductDetailSizeSelectionRouter()
        let presenter = ProductDetailSizeSelectionPresenter(view: view, router: router, delegate: delegate, arguments: arguments)
        view.presenter = presenter
        return (view, presenter)
    }
}

// MARK: - ProductDetailRouterInterface
extension ProductDetailSizeSelectionRouter: ProductDetailSizeSelectionRouterInterface {
    
}
