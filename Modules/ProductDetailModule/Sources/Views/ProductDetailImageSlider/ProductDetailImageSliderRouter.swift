//
//  ProductDetailImageSliderRouter.swift
//  ProductDetailModule
//
//  Created by Yasin Akbas on 13.03.2025.
//

import UIKit

protocol ProductDetailImageSliderRouterInterface: AnyObject {}

final class ProductDetailImageSliderRouter {
    static func createModule(arguments: ProductDetailImageSliderArguments) -> (ProductDetailImageSliderViewController, ProductDetailImageSliderModule) {
        let view = ProductDetailImageSliderViewController()
        let router = ProductDetailImageSliderRouter()
        let presenter = ProductDetailImageSliderPresenter(view: view, router: router, arguments: arguments)
        view.presenter = presenter
        return (view, presenter)
    }
}

// MARK: - ProductDetailImageSliderRouterInterface
extension ProductDetailImageSliderRouter: ProductDetailImageSliderRouterInterface { 
    
}

