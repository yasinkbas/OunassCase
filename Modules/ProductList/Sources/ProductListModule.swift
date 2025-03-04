//
//  ProductListModule.swift
//  OunassCase
//
//  Created by Yasin Akbas on 4.03.2025.
//

import UIKit
import DependencyManagerKit

public class ProductListModule {
    public init() {}
}

// MARK: - ProductListModuleInterface
extension ProductListModule: ProductListModuleInterface {
    public func productListViewController() -> UIViewController {
        ProductListViewController()
    }
}
