//
//  DependencyHandler.swift
//  OunassCase
//
//  Created by Yasin Akbas on 4.03.2025.
//

import CommonKit
import DependencyManagerKit
import ProductListModule
import ProductDetailModule
import BasketListModule

final class DependencyHandler {
    func registerDependencies() {
        DependencyEngine.shared.register(value: DeviceChecker(), for: DeviceCheckerInterface.self)
        DependencyEngine.shared.register(value: ProductListModule(), for: ProductListModuleInterface.self)
        DependencyEngine.shared.register(value: ProductDetailModule(), for: ProductDetailModuleInterface.self)
        DependencyEngine.shared.register(value: BasketListModule(), for: BasketListModuleInterface.self)
    }
}
