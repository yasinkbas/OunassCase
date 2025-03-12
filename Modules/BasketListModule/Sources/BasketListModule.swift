//
//  BasketListModule.swift
//  OunassCase
//
//  Created by Yasin Akbas on 12.03.2025.
//

import UIKit
import DependencyManagerKit

public class BasketListModule: BasketListModuleInterface {
    public init() {}
    
    public func basketViewController(using navigationController: UINavigationController) -> UIViewController {
        BasketListRouter.createModule(using: navigationController)
    }
}

