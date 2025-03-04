//
//  DependencyHandler.swift
//  OunassCase
//
//  Created by Yasin Akbas on 4.03.2025.
//

import DependencyManagerKit
import ProductList

final class DependencyHandler {
    func registerDependencies() {
        DependencyEngine.shared.register(value: ProductListModule(), for: ProductListModuleInterface.self)
    }
}
