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
        let navigationController = UINavigationController()
        let productListViewController = productListModule.productListViewController(usedNavigationController: navigationController)
        navigationController.pushViewController(productListViewController, animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
