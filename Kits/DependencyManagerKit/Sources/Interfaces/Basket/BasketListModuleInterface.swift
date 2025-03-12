//
//  BasketListModuleInterface.swift
//  OunassCase
//
//  Created by Yasin Akbas on 12.03.2025.
//

import UIKit

public protocol BasketListModuleInterface: AnyObject {
    func basketViewController(using navigationController: UINavigationController) -> UIViewController
}
