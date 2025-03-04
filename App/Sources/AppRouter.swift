//
//  AppRouter.swift
//  OunassCase
//
//  Created by Yasin Akbas on 4.03.2025.
//

import UIKit
import DependencyManagerKit

final class AppRouter {
    @Dependency var productListModule: ProductListModuleInterface
    
    let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    @MainActor func initializeRootViewController() {
        let productListViewController = productListModule.productListViewController()
        let navigationController = UINavigationController(rootViewController: productListViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
