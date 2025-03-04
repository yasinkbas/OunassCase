//
//  AppRouter.swift
//  OunassCase
//
//  Created by Yasin Akbas on 4.03.2025.
//

import UIKit

final class AppRouter {
    let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    @MainActor func initializeRootViewController() {
        let productListViewController = ViewController()
        let navigationController = UINavigationController(rootViewController: productListViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
