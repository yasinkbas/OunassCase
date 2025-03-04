//
//  AppDelegate.swift
//  OunassCase
//
//  Created by Yasin Akbas on 4.03.2025.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let container = AppContainer(window: window)
        container.router.initializeRootViewController()
        return true
    }
}
