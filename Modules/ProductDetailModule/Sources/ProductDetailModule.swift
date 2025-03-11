//
//  ProductDetailModule.swift
//  OunassCase
//
//  Created by Yasin Akbas on 10.03.2025.
//

import UIKit
import DependencyManagerKit

public class ProductDetailModule {
    public init() {}
}

// MARK: - ProductDetailModuleInterface
extension ProductDetailModule: ProductDetailModuleInterface {
    public func productDetailViewController(arguments: ProductDetailModuleArguments) -> UIViewController {
        ProductDetailRouter.createModule(with: .init(slug: arguments.slug, image: arguments.imageUrl))
    }
}
