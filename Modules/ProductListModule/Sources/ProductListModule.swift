//
//  ProductListModule.swift
//  OunassCase
//
//  Created by Yasin Akbas on 4.03.2025.
//

import UIKit
import DependencyManagerKit

public class ProductListModule {
    var controller: ProductListViewController? = nil
    public init() {}
}

// MARK: - ProductListModuleInterface
extension ProductListModule: ProductListModuleInterface {
    public func productListViewController(usedNavigationController navigationController: UINavigationController) -> UIViewController {
        controller = ProductListRouter.createModule(using: navigationController)
        return controller!
    }
}
