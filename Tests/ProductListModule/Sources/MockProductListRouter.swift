//
//  MockProductListRouter.swift
//  OunassCase
//
//  Created by Yasin Akbas on 8.03.2025.
//

import DependencyManagerKit
@testable import ProductListModule

final class MockProductListRouter: ProductListRouterInterface {

    var invokedRouteToDetail = false
    var invokedRouteToDetailCount = 0
    var invokedRouteToDetailParameters: (detailArguments: ProductDetailModuleArguments, Void)?
    var invokedRouteToDetailParametersList = [(detailArguments: ProductDetailModuleArguments, Void)]()

    func routeToDetail(detailArguments: ProductDetailModuleArguments) {
        invokedRouteToDetail = true
        invokedRouteToDetailCount += 1
        invokedRouteToDetailParameters = (detailArguments, ())
        invokedRouteToDetailParametersList.append((detailArguments, ()))
    }
}
