//
//  AppContainer.swift
//  OunassCase
//
//  Created by Yasin Akbas on 4.03.2025.
//

import UIKit

final class AppContainer {
    let router: AppRouter
    let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
        router = AppRouter(window: window)
        
        DependencyHandler().registerDependencies()
    }
}
