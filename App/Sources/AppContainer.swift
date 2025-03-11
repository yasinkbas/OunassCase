//
//  AppContainer.swift
//  OunassCase
//
//  Created by Yasin Akbas on 4.03.2025.
//

import UIKit
import UILab
import NetworkManagerKit

final class AppContainer {
    let router: AppRouter
    let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
        router = AppRouter(window: window)
        
        registerDependencies()
        prepareUILab()
    }
    
    private func registerDependencies() {
        DependencyHandler().registerDependencies()
    }
    
    func prepareUILab() {
        UILab.Settings.debugMonitoringType = .verbose
    }
}
